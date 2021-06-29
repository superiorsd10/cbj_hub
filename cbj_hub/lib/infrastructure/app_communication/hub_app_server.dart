import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/devices/basic_device/device_dtos.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:grpc/service_api.dart';

/// Server to get and send information to the app
class HubAppServer extends CbjHubServiceBase {
  /// The app call this method and getting stream of all the changes of the
  /// internet devices
  Stream<MapEntry<String, String>> streamOfChanges() async* {}

  @override
  Stream<SmartDeviceInfo> clientTransferDevices(
      ServiceCall call, Stream<SmartDeviceInfo> request) async* {
    print('Got new Client');
    getIt<IAppCommunicationRepository>().getFromApp(request);

    final Iterable<SmartDeviceInfo> allDevices = getIt<ILocalDbRepository>()
        .getSmartDevices()
        .map((DeviceEntity e) => DeviceDtos.fromDomain(e).toSmartDeviceInfo());

    for (final SmartDeviceInfo responseToHub in allDevices) {
      yield responseToHub;
    }

    yield* AppClientStream.stream.map((DeviceEntity deviceEntity) =>
        DeviceDtos.fromDomain(deviceEntity).toSmartDeviceInfo());
  }

  @override
  Stream<SmartDeviceInfo> hubTransferDevices(
      ServiceCall call, Stream<SmartDeviceInfo> request) async* {
    // TODO: implement registerHub
    throw UnimplementedError();
  }
}
