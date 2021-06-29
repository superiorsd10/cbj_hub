import 'package:cbj_hub/domain/devices/device_entity.dart';
import 'package:cbj_hub/domain/devices/value_objects.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pb.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalDbRepository)
class LocalDbRepository extends ILocalDbRepository {
  @override
  List<DeviceEntity> getSmartDevices() {
    final DeviceEntity deviceEntity = DeviceEntity(
      id: DeviceUniqueId(),
      defaultName: DeviceDefaultName('Ceiling'),
      roomId: DeviceUniqueId(),
      roomName: DeviceRoomName('Guy'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      stateMassage: DeviceStateMassage('Hello World'),
      senderDeviceOs: DeviceSenderDeviceOs('Linux'),
      senderDeviceModel: DeviceSenderDeviceModel('Computer'),
      senderId: DeviceSenderId(),
      deviceActions: DeviceAction(DeviceActions.on.toString()),
      deviceTypes: DeviceType(DeviceTypes.light.toString()),
      compUuid: DeviceCompUuid('Comp1'),
      lastKnownIp: DeviceLastKnownIp('10.0.0.7'),
      powerConsumption: DevicePowerConsumption('0'),
      deviceMdnsName: DeviceMdnsName('CeilingGuy'),
      deviceSecondWiFi: DeviceSecondWiFiName('test'),
    );

    return [deviceEntity];
  }

  @override
  void saveSmartDevices(List<DeviceEntity> deviceList) {
    // TODO: implement saveSmartDevices
  }
}

// /// Stream of saving all devices changes
// class AppClientStream {
//   static StreamController<MapEntry<String, String>> controller =
//       StreamController();
//
//   static Stream<MapEntry<String, String>> get stream =>
//       controller.stream.asBroadcastStream();
// }
