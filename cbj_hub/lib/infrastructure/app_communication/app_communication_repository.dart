import 'dart:async';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/infrastructure/app_communication/hub_app_server.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';

@LazySingleton(as: IAppCommunicationRepository)
class AppCommunicationRepository extends IAppCommunicationRepository {
  AppCommunicationRepository() {
    startLocalServer();
  }

  Future startLocalServer() async {
    final server = Server([HubAppServer()]);
    await server.serve(port: 50055);
    print('Hub Server listening for apps clients on port ${server.port}...');
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
          .forEach((deviceEntityToSend) {
        final DeviceEntityDtoAbstract deviceDtoAbstract =
            DeviceHelper.convertDomainToDto(deviceEntityToSend);
        AppClientStream.controller.sink.add(deviceDtoAbstract);
      });

      // print('Will send the topic "${event.payload.variableHeader?.topicName}" '
      //     'change with massage '
      //     '"${String.fromCharCodes(event.payload.message!)}" to the app ');
    });
  }

  @override
  Future<void> getFromApp(Stream<ClientStatusRequests> request) async {
    request.listen((event) {
      print('Got From App');

      if (event.sendingType == SendingType.deviceType) {
        HubClientStream.controller.sink.add(
            DeviceHelper.convertJsonStringToDomain(event.allRemoteCommands));
      } else {
        print('Request from app does not support this sending device type');
      }
    });
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class AppClientStream {
  static StreamController<DeviceEntityDtoAbstract> controller =
      StreamController();

  static Stream<DeviceEntityDtoAbstract> get stream =>
      controller.stream.asBroadcastStream();
}

/// Requests and responses from the app into the hub
class HubClientStream {
  static StreamController<DeviceEntityAbstract> controller = StreamController();

  static Stream<DeviceEntityAbstract> get stream =>
      controller.stream.asBroadcastStream();
}
