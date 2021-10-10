import 'dart:async';

import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/generic_blinds_device/generic_blinds_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/app_communication/hub_app_server.dart';
import 'package:cbj_hub/infrastructure/app_communication/remote_pipes_client.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/vendor_helper.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IAppCommunicationRepository)
class AppCommunicationRepository extends IAppCommunicationRepository {
  AppCommunicationRepository() {
    if (currentEnv == Env.prod) {
      hubPort = 60055;
    } else {
      hubPort = 50055;
    }
    startLocalServer();
    startRemotePipesConnection();
  }

  /// Port to connect to the cbj hub, will change according to the current
  /// running environment
  late int hubPort;

  Future startLocalServer() async {
    final server = Server([HubAppServer()]);
    await server.serve(port: hubPort);
    logger.i('Hub Server listening for apps clients on port ${server.port}...');
  }

  Future startRemotePipesConnection() async {
    RemotePipesClient.createStreamWithHub('172.104.231.123', 50051);
    // RemotePipesClient.createStreamWithHub('192.168.31.154', 50051);
    // RemotePipesClient.createStreamWithHub('127.0.0.1', 50051);
    logger.i('Creating connection with remote pipes');
  }

  @override
  void sendToApp(Stream<MqttPublishMessage> dataToSend) {
    dataToSend.listen((MqttPublishMessage event) async {
      logger.i('Got AppRequestsToHub');

      (await getIt<ISavedDevicesRepo>().getAllDevices())
          .forEach((String id, deviceEntityToSend) {
        final DeviceEntityDtoAbstract deviceDtoAbstract =
            DeviceHelper.convertDomainToDto(deviceEntityToSend);
        HubRequestsToApp.streamRequestsToApp.sink.add(deviceDtoAbstract);
      });
    });
  }

  @override
  Future<void> getFromApp(Stream<ClientStatusRequests> request) async {
    request.listen((event) async {
      logger.i('Got From App');

      if (event.sendingType == SendingType.deviceType) {
        final DeviceEntityAbstract deviceEntityFromApp =
            DeviceHelper.convertJsonStringToDomain(event.allRemoteCommands);

        sendToMqtt(deviceEntityFromApp);
      } else if (event.sendingType == SendingType.vendorLoginType) {
        final LoginEntityAbstract loginEntityFromApp =
            VendorHelper.convertJsonStringToDomain(event.allRemoteCommands);

        sendLoginToVendor(loginEntityFromApp);
      } else {
        logger.w('Request from app does not support this sending device type');
      }
    }).onError((error) => logger.e('Stream getFromApp have error $error'));
  }

  static Future<void> sendToMqtt(
    DeviceEntityAbstract deviceEntityFromApp,
  ) async {
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();
    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();
    final DeviceEntityAbstract? savedDeviceEntity =
        allDevices[deviceEntityFromApp.getDeviceId()];

    if (savedDeviceEntity == null) {
      logger.w('Device id does not match existing device');
      return;
    }

    MapEntry<String, DeviceEntityAbstract> deviceFromApp;

    if (savedDeviceEntity is GenericLightDE &&
        deviceEntityFromApp is GenericLightDE) {
      savedDeviceEntity.lightSwitchState = deviceEntityFromApp.lightSwitchState;

      deviceFromApp =
          MapEntry(savedDeviceEntity.uniqueId.getOrCrash()!, savedDeviceEntity);
    } else if (savedDeviceEntity is GenericRgbwLightDE &&
        deviceEntityFromApp is GenericRgbwLightDE) {
      savedDeviceEntity.lightSwitchState = deviceEntityFromApp.lightSwitchState;
      savedDeviceEntity.lightColorSaturation =
          deviceEntityFromApp.lightColorSaturation;
      savedDeviceEntity.lightColorHue = deviceEntityFromApp.lightColorHue;
      savedDeviceEntity.lightColorAlpha = deviceEntityFromApp.lightColorAlpha;
      savedDeviceEntity.lightColorValue = deviceEntityFromApp.lightColorValue;

      deviceFromApp =
          MapEntry(savedDeviceEntity.uniqueId.getOrCrash()!, savedDeviceEntity);
    } else if (savedDeviceEntity is GenericBoilerDE &&
        deviceEntityFromApp is GenericBoilerDE) {
      savedDeviceEntity.boilerSwitchState =
          deviceEntityFromApp.boilerSwitchState;

      deviceFromApp =
          MapEntry(savedDeviceEntity.uniqueId.getOrCrash()!, savedDeviceEntity);
    } else if (savedDeviceEntity is GenericBlindsDE &&
        deviceEntityFromApp is GenericBlindsDE) {
      savedDeviceEntity.blindsSwitchState =
          deviceEntityFromApp.blindsSwitchState;

      deviceFromApp =
          MapEntry(savedDeviceEntity.uniqueId.getOrCrash()!, savedDeviceEntity);
    } else {
      logger.w('Cant find device from app type');
      return;
    }
    ConnectorStreamToMqtt.toMqttController.sink.add(deviceFromApp);
  }

  static Future<void> sendLoginToVendor(
    LoginEntityAbstract loginEntityFromApp,
  ) async {
    CompanysConnectorConjector.setVendorLoginCredentials(loginEntityFromApp);
  }

  static Future<void> sendAllDevicesToHubRequestsStream() async {
    (await getIt<ISavedDevicesRepo>().getAllDevices())
        .map((String id, DeviceEntityAbstract d) {
      HubRequestsToApp.streamRequestsToApp.sink.add(d.toInfrastructure());
      return MapEntry(id, DeviceHelper.convertDomainToJsonString(d));
    });
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class HubRequestsToApp {
  static BehaviorSubject<DeviceEntityDtoAbstract> streamRequestsToApp =
      BehaviorSubject<DeviceEntityDtoAbstract>();
}

/// Requests and updates from app to the hub
class AppRequestsToHub {
  /// Stream controller of the requests from the hub
  static final hubRequestsStreamController =
      StreamController<RequestsAndStatusFromHub>();

  /// Stream of the requests from the hub
  static Stream<RequestsAndStatusFromHub> get hubRequestsStream =>
      hubRequestsStreamController.stream;
}
