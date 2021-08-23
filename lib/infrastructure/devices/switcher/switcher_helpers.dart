import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_v2/switcher_v2_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';

class SwitcherHelpers {
  static DeviceEntityAbstract? addDiscoverdDevice(
      SwitcherApiObject switcherDevice) {

    if(switcherDevice.deviceType == SwitcherDevicesTypes.switcherV2Esp ||
        switcherDevice.deviceType == SwitcherDevicesTypes.switcherV2qualcomm) {
      final SwitcherV2Entity switcherV2DE = SwitcherV2Entity(
        uniqueId: CoreUniqueId(),
        defaultName: DeviceDefaultName('Switcher test 2'),
        roomId: CoreUniqueId.newDevicesRoom(),
        roomName: DeviceRoomName(' '),
        deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('switcher'),
        senderDeviceModel: DeviceSenderDeviceModel('1SE'),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid('34asdfrsd23gggg'),
        lastKnownIp: DeviceLastKnownIp(switcherDevice.ipAddress),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption: DevicePowerConsumption('0'),
        lightSwitchState:
        GenericLightSwitchState(DeviceActions.actionNotSupported.toString()),
        switcherDeviceId: SwitcherDeviceId(switcherDevice.deviceId),
      );

      return switcherV2DE;
    }
    return null;
  }
}
