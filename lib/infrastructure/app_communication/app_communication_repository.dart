import 'dart:async';

import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/infrastructure/app_communication/hub_app_server.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/injection.dart';
import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IAppCommunicationRepository)
class AppCommunicationRepository extends IAppCommunicationRepository {
  AppCommunicationRepository() {
    if(currentEnv == Env.prod){
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
    print('Hub Server listening for apps clients on port ${server.port}...');
  }

  Future startRemotePipesConnection() async {
    // RemotePipesClient.createStreamWithHub('', 50051);
    // RemotePipesClient.createStreamWithHub('127.0.0.1', 50051);
    print('Creating connection with remote pipes');
  }

  @override
  void sendToApp(Stream<MqttPublishMessage> dataToSend) {
    dataToSend.listen((MqttPublishMessage event) async {
      print('Got AppRequestsToHub');

      // final DeviceEntity deviceEntityToSend = getIt<ILocalDbRepository>()
      //     .getSmartDevices()
      //     .firstWhere((element) =>
      //         element.id!.getOrCrash() == event.variableHeader?.topicName);

      (await getIt<ISavedDevicesRepo>().getAllDevices())
          .forEach((String id, deviceEntityToSend) {
        final DeviceEntityDtoAbstract deviceDtoAbstract =
            DeviceHelper.convertDomainToDto(deviceEntityToSend);
        HubRequestsToApp.streamRequestsToApp.sink.add(deviceDtoAbstract);
      });

      // print('Will send the topic "${event.payload.variableHeader?.topicName}" '
      //     'change with massage '
      //     '"${String.fromCharCodes(event.payload.message!)}" to the app ');
    });
  }

  @override
  Future<void> getFromApp(Stream<ClientStatusRequests> request) async {
    request.listen((event) async {
      print('Got From App');

      if (event.sendingType == SendingType.deviceType) {
        final DeviceEntityAbstract deviceEntityFromApp =
            DeviceHelper.convertJsonStringToDomain(event.allRemoteCommands);

        seindToMqtt(deviceEntityFromApp);
      } else {
        print('Request from app does not support this sending device type');
      }
    }).onError((error) => print('Stream getFromApp have error $error'));
  }

  static Future<void> seindToMqtt(
      DeviceEntityAbstract deviceEntityFromApp) async {
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();
    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();
    final DeviceEntityAbstract? savedDeviceEntity =
        allDevices[deviceEntityFromApp.getDeviceId()];

    if (savedDeviceEntity == null) {
      print('Device id does not match existing device');
      return;
    }

    MapEntry<String, DeviceEntityAbstract> deviceFromApp;

    if (savedDeviceEntity is GenericLightDE) {
      final GenericLightDE savedDeviceEntityFromApp =
          deviceEntityFromApp as GenericLightDE;
      savedDeviceEntity.lightSwitchState =
          savedDeviceEntityFromApp.lightSwitchState;

      deviceFromApp =
          MapEntry(savedDeviceEntity.uniqueId.getOrCrash()!, savedDeviceEntity);
    } else if (savedDeviceEntity is GenericRgbwLightDE) {
      final GenericRgbwLightDE savedDeviceEntityFromApp =
          deviceEntityFromApp as GenericRgbwLightDE;
      savedDeviceEntity.lightSwitchState =
          savedDeviceEntityFromApp.lightSwitchState;

      deviceFromApp =
          MapEntry(savedDeviceEntity.uniqueId.getOrCrash()!, savedDeviceEntity);
    } else {
      print('Cant find device from app type');
      return;
    }
    ConnectorStreamToMqtt.toMqttController.sink.add(deviceFromApp);
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
