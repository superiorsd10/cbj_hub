import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_device_entity.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_value_objects.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalDbRepository)
class LocalDbRepository extends ILocalDbRepository {
  @override
  Map<String, DeviceEntityAbstract> getSmartDevices() {
    final String guyRoomId = CoreUniqueId().getOrCrash()!;

    final SonoffS20DE firstRealDeviceTest = SonoffS20DE(
      id: CoreUniqueId.fromUniqueString('0ecb1040-e724-11eb-8cec-954d01dcce33'),
      defaultName: DeviceDefaultName('guy ceiling'),
      roomId: CoreUniqueId(),
      roomName: DeviceRoomName('Guyy'),
      deviceStateGRPC: DeviceState(
          EnumHelper.deviceStateToString(DeviceStateGRPC.waitingInComp)),
      senderDeviceOs: DeviceSenderDeviceOs('ESPHome'),
      senderDeviceModel: DeviceSenderDeviceModel('ESP8266 D1 R1'),
      stateMassage: DeviceStateMassage('Test'),
      senderId: DeviceSenderId(),
      deviceActions:
          DeviceAction(EnumHelper.deviceActionToString(DeviceActions.off)),
      deviceTypes: DeviceType(EnumHelper.dTToString(DeviceTypes.light)),
      compUuid: DeviceCompUuid('9C:9D:7E:48:60:48'),
      lastKnownIp: DeviceLastKnownIp('192.168.31.21'),
      deviceSecondWiFi: DeviceSecondWiFiName('amiuz2'),
      deviceMdnsName: DeviceMdnsName('guy_ceiling.local'),
      powerConsumption: DevicePowerConsumption('0'),
      sonoffS20SwitchKey: SonoffS20SwitchKey('1360107432'),
    );

    final SonoffS20DE sonoffS20 = SonoffS20DE(
      id: CoreUniqueId(),
      defaultName: DeviceDefaultName('Ceiling'),
      roomId: CoreUniqueId.fromUniqueString(guyRoomId),
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
      deviceSecondWiFi: DeviceSecondWiFiName('amiuz2'),
    );

    final DeviceEntity deviceEntity = DeviceEntity(
      id: CoreUniqueId(),
      defaultName: DeviceDefaultName('Ceiling'),
      roomId: CoreUniqueId.fromUniqueString(guyRoomId),
      roomName: DeviceRoomName('Guy'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      stateMassage: DeviceStateMassage('Hello World'),
      senderDeviceOs: DeviceSenderDeviceOs('Linux'),
      senderDeviceModel: DeviceSenderDeviceModel('Computer'),
      senderId: DeviceSenderId(),
      deviceActions: DeviceAction(DeviceActions.on.toString()),
      deviceTypes: DeviceType(DeviceTypes.light.toString()),
      compUuid: DeviceCompUuid('Comp1'),
      lastKnownIp: DeviceLastKnownIp('10.0.0.54'),
      powerConsumption: DevicePowerConsumption('0'),
      deviceMdnsName: DeviceMdnsName('CeilingGuy'),
      deviceSecondWiFi: DeviceSecondWiFiName('amiuz2'),
    );

    final DeviceEntity deviceEntityS = DeviceEntity(
      id: CoreUniqueId(),
      defaultName: DeviceDefaultName('top'),
      roomId: CoreUniqueId(),
      roomName: DeviceRoomName('Omer'),
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
      deviceSecondWiFi: DeviceSecondWiFiName('amiuz2'),
    );

    return {firstRealDeviceTest.id!.getOrCrash()!: firstRealDeviceTest};
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
