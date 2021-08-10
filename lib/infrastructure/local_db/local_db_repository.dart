import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_1se_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalDbRepository)
class LocalDbRepository extends ILocalDbRepository {
  @override
  Map<String, DeviceEntityAbstract> getSmartDevicesFromDb() {
    final String guyRoomId = CoreUniqueId().getOrCrash()!;

    final Yeelight1SeEntity yeelightDE = Yeelight1SeEntity(
      uniqueId: CoreUniqueId(),
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
      yeelightDeviceId: YeelightDeviceId('249185746'),
      yeelightPort: YeelightPort('55443'),
      lightSwitchState:
          GenericLightSwitchState(DeviceActions.actionNotSupported.toString()),
    );

    return {
      // firstRealDeviceTest.id!.getOrCrash()!: firstRealDeviceTest,
      // espHome.id!.getOrCrash()!: espHome,
      yeelightDE.uniqueId.getOrCrash()!: yeelightDE,
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
  void saveSmartDevices(List<DeviceEntityAbstract> deviceList) {
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
