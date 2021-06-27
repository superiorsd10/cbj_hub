import 'dart:async';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/hub_app_server.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
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
      AppClientStream.controller.sink.add(MapEntry(
          event.payload.variableHeader!.topicName,
          event.payload.message!.toString()));
      // print('Will send the topic "${event.payload.variableHeader?.topicName}" '
      //     'change with massage '
      //     '"${String.fromCharCodes(event.payload.message!)}" to the app ');
    });
  }

  @override
  Stream<MqttPublishMessage> getFromApp(
      Stream<ClientStatusRequests> request) async* {
    yield* request.map((event) => MqttPublishMessage());
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class AppClientStream {
  static StreamController<MapEntry<String, String>> controller =
      StreamController();

  static Stream<MapEntry<String, String>> get stream =>
      controller.stream.asBroadcastStream();
}
