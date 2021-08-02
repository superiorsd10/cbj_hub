import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
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
    try {
      print('Got new Client');

      getIt<IAppCommunicationRepository>().getFromApp(request);

      final Map<String, String> allDevices =
          (await getIt<ISavedDevicesRepo>().getAllDevices())
              .map((String id, DeviceEntityAbstract d) {
        return MapEntry(id, DeviceHelper.convertDomainToJsonString(d));
      });

      /// Each first connection to the server send all saved devices
      for (final String responseToHub in allDevices.values) {
        yield RequestsAndStatusFromHub(
          sendingType: SendingType.deviceType,
          allRemoteCommands: responseToHub,
        );
      }

      yield* AppClientStream.streamRequestsFromAPp
          .map((DeviceEntityDtoAbstract deviceEntityDto) =>
              RequestsAndStatusFromHub(
                sendingType: SendingType.deviceType,
                allRemoteCommands:
                    DeviceHelper.convertDtoToJsonString(deviceEntityDto),
              ))
          .handleError((error) => print('Stream have error $error'));
    } catch (e) {
      print('Hub server error $e');
    }
  }

  @override
  Stream<ClientStatusRequests> hubTransferDevices(
      ServiceCall call, Stream<RequestsAndStatusFromHub> request) async* {
    // TODO: implement registerHub
    throw UnimplementedError();
  }
}
