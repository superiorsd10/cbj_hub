import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_entity.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_value_objects.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalDbRepository)
class LocalDbRepository extends ILocalDbRepository {
  @override
  Map<String, DeviceEntityAbstract> getSmartDevicesFromDb() {
    final String guyRoomId = CoreUniqueId().getOrCrash()!;

    final ESPHomeDE firstRealDeviceTest = ESPHomeDE(
      id: CoreUniqueId.fromUniqueString('0ecb1040-e724-11eb-8cec-954d01dcce33'),
      defaultName: DeviceDefaultName('guy ceiling'),
      roomId: CoreUniqueId(),
      roomName: DeviceRoomName('Guyy Esp1'),
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
      lastKnownIp: DeviceLastKnownIp('192.168.31.66'),
      deviceSecondWiFi: DeviceSecondWiFiName('amiuz2'),
      deviceMdnsName: DeviceMdnsName('livingroom.local'),
      powerConsumption: DevicePowerConsumption('0'),
      espHomeSwitchKey: ESPHomeSwitchKey('1711856045'),
    );

    final ESPHomeDE espHome = ESPHomeDE(
      id: CoreUniqueId(),
      defaultName: DeviceDefaultName('test esp2'),
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
      espHomeSwitchKey: ESPHomeSwitchKey('1711856045'),
    );

    final DeviceEntity deviceEntity = DeviceEntity(
      id: CoreUniqueId(),
      defaultName: DeviceDefaultName('DeviceEntity test 1'),
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

    final GenericLightDE yeelightDE = GenericLightDE(
      id: CoreUniqueId(),
      defaultName: DeviceDefaultName('Yeelight test 1'),
      roomId: CoreUniqueId(),
      roomName: DeviceRoomName('Guy'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('yeelight'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      deviceActions: DeviceAction(DeviceActions.on.toString()),
      deviceTypes: DeviceType(DeviceTypes.light.toString()),
      compUuid: DeviceCompUuid('34asd23gggg'),
      deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
      lastKnownIp: DeviceLastKnownIp('192.168.31.129'),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      deviceSecondWiFi: DeviceSecondWiFiName('amiuz2'),

      // yeelightDeviceId: YeelightDeviceId('249185746'),
      // yeelightPort: YeelightPort('55443'),
    );

    return {
      // firstRealDeviceTest.id!.getOrCrash()!: firstRealDeviceTest,
      // espHome.id!.getOrCrash()!: espHome,
      yeelightDE.id!.getOrCrash()!: yeelightDE,
    };
  }

  //   final YeelightDE yeelightDE = YeelightDE(
  //     id: CoreUniqueId(),
  //     defaultName: DeviceDefaultName('Yeelight test 1'),
  //     roomId: CoreUniqueId(),
  //     roomName: DeviceRoomName('Guy'),
  //     deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
  //     senderDeviceOs: DeviceSenderDeviceOs('yeelight'),
  //     senderDeviceModel: DeviceSenderDeviceModel('1SE'),
  //     senderId: DeviceSenderId(),
  //     deviceActions: DeviceAction(DeviceActions.on.toString()),
  //     deviceTypes: DeviceType(DeviceTypes.light.toString()),
  //     compUuid: DeviceCompUuid('34asd23gggg'),
  //     deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
  //     lastKnownIp: DeviceLastKnownIp('192.168.31.129'),
  //     yeelightDeviceId: YeelightDeviceId('249185746'),
  //     yeelightPort: YeelightPort('55443'),
  //     stateMassage: DeviceStateMassage('Hello World'),
  //     powerConsumption: DevicePowerConsumption('0'),
  //     deviceSecondWiFi: DeviceSecondWiFiName('amiuz2'),
  //   );
  //
  //   return {
  //     // firstRealDeviceTest.id!.getOrCrash()!: firstRealDeviceTest,
  //     // espHome.id!.getOrCrash()!: espHome,
  //     yeelightDE.id!.getOrCrash()!: yeelightDE,
  //   };
  // }

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
