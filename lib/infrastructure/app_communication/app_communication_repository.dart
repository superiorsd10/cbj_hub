import 'dart:async';
import 'dart:convert';

import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/generic_blinds_device/generic_blinds_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_empty_device/generic_empty_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/remote_pipes/remote_pipes_entity.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/app_communication/hub_app_server.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/generic_vendors_login/vendor_helper.dart';
import 'package:cbj_hub/infrastructure/remote_pipes/remote_pipes_client.dart';
import 'package:cbj_hub/infrastructure/remote_pipes/remote_pipes_dtos.dart';
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
      hubPort = 50055;
    } else {
      hubPort = 60055;
    }
    startLocalServer();
  }

  /// Port to connect to the cbj hub, will change according to the current
  /// running environment
  late int hubPort;

  Future startLocalServer() async {
    final server = Server([HubAppServer()]);
    await server.serve(port: hubPort);
    logger.i('Hub Server listening for apps clients on port ${server.port}...');
  }

  @override
  Future<void> startRemotePipesConnection(String remotePipesDomain) async {
    RemotePipesClient.createStreamWithHub(
      remotePipesDomain,
      // 'homeservice-one-service.default.g.com',
      50056,
    );
    // Here for easy find and local testing
    // RemotePipesClient.createStreamWithHub('127.0.0.1', 50056);
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

        getIt<ILocalDbRepository>()
            .saveAndActivateVendorLoginCredentialsDomainToDb(
          loginEntityFromApp,
        );
      } else if (event.sendingType == SendingType.firstConnection) {
        AppCommunicationRepository.sendAllDevicesFromHubRequestsStream();
      } else if (event.sendingType == SendingType.remotePipesInformation) {
        final Map<String, dynamic> jsonDecoded =
            jsonDecode(event.allRemoteCommands) as Map<String, dynamic>;

        final RemotePipesEntity remotePipes =
            RemotePipesDtos.fromJson(jsonDecoded).toDomain();

        getIt<ILocalDbRepository>()
            .saveAndActivateRemotePipesDomainToDb(remotePipes);
      } else {
        logger.w('Request from app does not support this sending device type');
      }
    }).onError((error) {
      if (error is GrpcError && error.code == 1) {
        logger.v('Client have disconnected');
      } else {
        logger.e('Client stream error: $error');
      }
    });
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
      savedDeviceEntity.lightColorTemperature =
          deviceEntityFromApp.lightColorTemperature;
      savedDeviceEntity.lightColorHue = deviceEntityFromApp.lightColorHue;
      savedDeviceEntity.lightColorAlpha = deviceEntityFromApp.lightColorAlpha;
      savedDeviceEntity.lightColorValue = deviceEntityFromApp.lightColorValue;
      savedDeviceEntity.lightBrightness = deviceEntityFromApp.lightBrightness;

      deviceFromApp =
          MapEntry(savedDeviceEntity.uniqueId.getOrCrash()!, savedDeviceEntity);
    } else if (savedDeviceEntity is GenericSwitchDE &&
        deviceEntityFromApp is GenericSwitchDE) {
      savedDeviceEntity.switchState = deviceEntityFromApp.switchState;

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
      logger.w(
        'Cant find device from app type '
        '${deviceEntityFromApp.deviceTypes.getOrCrash()}',
      );
      return;
    }
    ConnectorStreamToMqtt.toMqttController.sink.add(deviceFromApp);
  }

  /// Trigger to send all devices from hub to app using the
  /// HubRequestsToApp stream
  static Future<void> sendAllDevicesFromHubRequestsStream() async {
    final Map<String, DeviceEntityAbstract> allDevices =
        await getIt<ISavedDevicesRepo>().getAllDevices();

    final Map<String, RoomEntity> allRooms =
        await getIt<ISavedDevicesRepo>().getAllRooms();

    if (allRooms.isNotEmpty) {
      allRooms.map((String id, RoomEntity d) {
        HubRequestsToApp.streamRequestsToApp.sink.add(d.toInfrastructure());
        return MapEntry(id, jsonEncode(d.toInfrastructure().toJson()));
      });

      allDevices.map((String id, DeviceEntityAbstract d) {
        HubRequestsToApp.streamRequestsToApp.sink.add(d.toInfrastructure());
        return MapEntry(id, DeviceHelper.convertDomainToJsonString(d));
      });
    } else {
      logger.w("Can't find smart devices in the network, sending empty");
      final DeviceEntityAbstract emptyDevice = GenericEmptyDE.empty();
      HubRequestsToApp.streamRequestsToApp.sink
          .add(emptyDevice.toInfrastructure());
    }
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class HubRequestsToApp {
  static BehaviorSubject<dynamic> streamRequestsToApp =
      BehaviorSubject<dynamic>();
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
