import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:grpc/service_api.dart';

/// Server to get and send information to the app
class HubAppServer extends CbjHubServiceBase {
  /// The app call this method and getting stream of all the changes of the
  /// internet devices
  Stream<MapEntry<String, String>> streamOfChanges() async* {}

  @override
  Stream<RequestsAndStatusFromHub> clientTransferDevices(
      ServiceCall call, Stream<ClientStatusRequests> request) async* {
    print('Got new Client');

    // getIt<IAppCommunicationRepository>().getFromApp(request);
    // final Iterable<String> allDevices =
    //     getIt<ILocalDbRepository>().getSmartDevices().map((dynamic e) {
    //   return DeviceHelper.convertDomainToJson(e);
    // });
    //
    // for (final String responseToHub in allDevices) {
    //   yield RequestsAndStatusFromHub(allRemoteCommands: responseToHub);
    // }
    //
    // yield* AppClientStream.stream.map((DeviceEntity deviceEntity) =>
    //     RequestsAndStatusFromHub(
    //         allRemoteCommands:
    //             jsonEncode(DeviceDtos.fromDomain(deviceEntity).toJson())));
  }

  @override
  Stream<ClientStatusRequests> hubTransferDevices(
      ServiceCall call, Stream<RequestsAndStatusFromHub> request) async* {
    // TODO: implement registerHub
    throw UnimplementedError();
  }
}
