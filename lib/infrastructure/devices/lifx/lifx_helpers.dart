import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_white/lifx_white_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:yeedart/yeedart.dart';

class LifxHelpers {
  static DeviceEntityAbstract addDiscoverdDevice(
    DiscoveryResponse lifxDevice,
  ) {
    final LifxWhiteEntity lifxDE = LifxWhiteEntity(
      uniqueId: CoreUniqueId(),
      defaultName: DeviceDefaultName(
        lifxDevice.name != '' ? lifxDevice.name : 'Lifx test 2',
      ),
      roomId: CoreUniqueId.newDevicesRoom(),
      roomName: DeviceRoomName('Discovered'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('lifx'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
      lastKnownIp: DeviceLastKnownIp(lifxDevice.address.address),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      lifxDeviceId: LifxDeviceId(lifxDevice.id.toString()),
      lifxPort: LifxPort(lifxDevice.port.toString()),
      lightSwitchState: GenericSwitchState(lifxDevice.powered.toString()),
    );

    return lifxDE;
  }
}
