import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:grpc/src/server/call.dart';

/// Server to get and send information to the app
class HubAppServer extends CbjServerServiceBase {
  /// The app call this method and getting stream of all the changes of the
  /// internet devices
  Stream<MapEntry<String, String>> streamOfChanges() async* {}

  @override
  Stream<RequestsAndStatusFromHub> registerClient(
      ServiceCall call, Stream<ClientStatusRequests> request) async* {
    yield* AppClientStream.stream.map((event) => RequestsAndStatusFromHub(
        allRemoteCommands: AllRemoteCommands(
            smartDeviceInfo: SmartDeviceInfo(
                mqttMassage: MqttMassage(
                    mqttTopic: event.key, mqttMassage: event.value)))));
  }

  @override
  Stream<ClientStatusRequests> registerHub(
      ServiceCall call, Stream<RequestsAndStatusFromHub> request) {
    // TODO: implement registerHub
    throw UnimplementedError();
  }
}
