import 'dart:async';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/hub_app_server.dart';
import 'package:cbj_hub/infrastructure/devices/basic_device/grpc_device_helpers.dart';
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
    dataToSend.listen((MqttPublishMessage event) {
      DeviceEntity deviceEntityToSend = getIt<ILocalDbRepository>()
          .getSmartDevices()
          .firstWhere((element) =>
              element.id!.getOrCrash() == event.variableHeader?.topicName);
      AppClientStream.controller.sink.add(deviceEntityToSend);
      // print('Will send the topic "${event.payload.variableHeader?.topicName}" '
      //     'change with massage '
      //     '"${String.fromCharCodes(event.payload.message!)}" to the app ');
    });
  }

  @override
  Stream<DeviceEntity> getFromApp(Stream<SmartDeviceInfo> request) async* {
    yield* request.map((event) => event.toDeviceEntity());
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class AppClientStream {
  static StreamController<DeviceEntity> controller = StreamController();

  static Stream<DeviceEntity> get stream =>
      controller.stream.asBroadcastStream();
}
