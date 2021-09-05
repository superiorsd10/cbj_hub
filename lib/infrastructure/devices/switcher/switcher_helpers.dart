import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_v2/switcher_v2_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';

class SwitcherHelpers {
  static DeviceEntityAbstract? addDiscoverdDevice(
      SwitcherApiObject switcherDevice) {
    if (switcherDevice.deviceType == SwitcherDevicesTypes.switcherV2Esp ||
        switcherDevice.deviceType == SwitcherDevicesTypes.switcherV2qualcomm) {
      final SwitcherV2Entity switcherV2DE = SwitcherV2Entity(
        uniqueId: CoreUniqueId(),
        defaultName: DeviceDefaultName(switcherDevice.switcherName),
        roomId: CoreUniqueId.newDevicesRoom(),
        roomName: DeviceRoomName('Discovered'),
        deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('switcher'),
        senderDeviceModel:
            DeviceSenderDeviceModel(switcherDevice.deviceType.toString()),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid('34asdfrsd23gggg'),
        lastKnownIp: DeviceLastKnownIp(switcherDevice.switcherIp),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption:
            DevicePowerConsumption(switcherDevice.powerConsumption),
        boilerSwitchState:
            GenericBoilerSwitchState(switcherDevice.deviceState.toString()),
        switcherDeviceId: SwitcherDeviceId(switcherDevice.deviceId),
        switcherPort: SwitcherPort(switcherDevice.port.toString()),
        switcherMacAddress: SwitcherMacAddress(switcherDevice.macAddress),
      );

      return switcherV2DE;
    }
    return null;
  }
}
