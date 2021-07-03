import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/devices/abstact_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
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

    getIt<IAppCommunicationRepository>().getFromApp(request);

    final Iterable<String> allDevices = getIt<ILocalDbRepository>()
        .getSmartDevices()
        .map((DeviceEntityAbstract e) {
      return DeviceHelper.convertDomainToJsonString(e);
    });

    for (final String responseToHub in allDevices) {
      yield RequestsAndStatusFromHub(allRemoteCommands: responseToHub);
    }

    yield* AppClientStream.stream.map((DeviceEntityAbstract deviceEntity) =>
        RequestsAndStatusFromHub(
            allRemoteCommands:
                DeviceHelper.convertDomainToJsonString(deviceEntity)));
  }

  @override
  Stream<ClientStatusRequests> hubTransferDevices(
      ServiceCall call, Stream<RequestsAndStatusFromHub> request) async* {
    // TODO: implement registerHub
    throw UnimplementedError();
  }
}
