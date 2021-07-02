import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/domain/devices/basic_device/value_objects.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_device_entity.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_value_objects.dart';
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

    final SonoffS20DE sonoffS20 = SonoffS20DE(
      id: SonoffS20UniqueId(),
      defaultName: SonoffS20DefaultName('Ceiling'),
      roomId: SonoffS20UniqueId(),
      roomName: SonoffS20RoomName('Guy'),
      deviceStateGRPC: SonoffS20State(DeviceStateGRPC.ack.toString()),
      stateMassage: SonoffS20StateMassage('Hello World'),
      senderDeviceOs: SonoffS20SenderDeviceOs('Linux'),
      senderDeviceModel: SonoffS20SenderDeviceModel('Computer'),
      senderId: SonoffS20SenderId(),
      deviceActions: SonoffS20Action(DeviceActions.on.toString()),
      deviceTypes: SonoffS20Type(DeviceTypes.light.toString()),
      compUuid: SonoffS20CompUuid('Comp1'),
      lastKnownIp: SonoffS20LastKnownIp('10.0.0.7'),
      powerConsumption: SonoffS20PowerConsumption('0'),
      deviceMdnsName: SonoffS20MdnsName('CeilingGuy'),
      deviceSecondWiFi: SonoffS20SecondWiFiName('test'),
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
