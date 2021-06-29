import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/devices/device_entity.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:grpc/service_api.dart';

/// Server to get and send information to the app
class HubAppServer extends CbjHubServiceBase {
  /// The app call this method and getting stream of all the changes of the
  /// internet devices
  Stream<MapEntry<String, String>> streamOfChanges() async* {}

  @override
  Stream<RequestsAndStatusFromHub> registerClient(
      ServiceCall call, Stream<ClientStatusRequests> request) async* {
    print('Got new Client');
    getIt<IAppCommunicationRepository>().getFromApp(request);

    final Iterable<RequestsAndStatusFromHub> allDevices =
        getIt<ILocalDbRepository>()
            .getSmartDevices()
            .map((DeviceEntity e) => RequestsAndStatusFromHub(
                    allRemoteCommands: AllRemoteCommands(
                        smartDeviceInfo: SmartDeviceInfo(
                  id: e.id!.getOrCrash(),
                  state: e.deviceStateGRPC!.getOrCrash(),
                  defaultName: e.defaultName!.getOrCrash(),
                  roomId: e.roomId!.getOrCrash(),
                  senderDeviceModel: e.senderDeviceModel!.getOrCrash(),
                  senderDeviceOs: e.senderDeviceOs!.getOrCrash(),
                  senderId: e.senderId!.getOrCrash(),
                  serverTimeStamp: '10',
                  stateMassage: e.stateMassage!.getOrCrash(),
                  mqttMassage: MqttMassage(
                    mqttTopic: e.defaultName!.getOrCrash(),
                    mqttMassage: e.stateMassage!.getOrCrash(),
                  ),
                  isComputer: false,
                  compSpecs: CompSpecs(),
                  microcontrollerSpecsSpecs: MicrocontrollerSpecs(),
                  deviceTypesActions: DeviceTypesActions(
                    deviceType:
                        DeviceTypes.light /* e.deviceTypes!.getOrCrash()*/,
                    deviceAction:
                        DeviceActions.on /* e.deviceActions!.getOrCrash()*/,
                    deviceStateGRPC: DeviceStateGRPC
                        .ack, /* e.deviceStateGRPC!.getOrCrash()*/
                  ),
                ))));

    for (final RequestsAndStatusFromHub responseToHub in allDevices) {
      yield responseToHub;
    }

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
