import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_jbt_a70_rgbcw_wf/tuya_smart_jbt_a70_rgbcw_wf_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:yeedart/yeedart.dart';

class TuyaSmartHelpers {
  static DeviceEntityAbstract addDiscoverdDevice(
    DiscoveryResponse tuya_smartDevice,
  ) {
    final TuyaSmartJbtA70RgbcwWfEntityEntity tuyaSmartDE =
        TuyaSmartJbtA70RgbcwWfEntityEntity(
      uniqueId: CoreUniqueId(),
      defaultName: DeviceDefaultName(
        tuya_smartDevice.name != ''
            ? tuya_smartDevice.name
            : 'TuyaSmart test 2',
      ),
      roomId: CoreUniqueId.newDevicesRoom(),
      roomName: DeviceRoomName('Discovered'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('tuya_smart'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
      lastKnownIp: DeviceLastKnownIp(tuya_smartDevice.address.address),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      tuyaSmartDeviceId: TuyaSmartDeviceId(tuya_smartDevice.id.toString()),
      tuyaSmartPort: TuyaSmartPort(tuya_smartDevice.port.toString()),
      lightSwitchState:
          GenericRgbwLightSwitchState(tuya_smartDevice.powered.toString()),
      lightColorTemperature: GenericRgbwLightColorTemperature(
        tuya_smartDevice.colorTemperature.toString(),
      ),
      lightBrightness:
          GenericRgbwLightBrightness(tuya_smartDevice.brightness.toString()),
      lightColorAlpha: GenericRgbwLightColorAlpha('1.0'),
      lightColorHue: GenericRgbwLightColorHue('0.0'),
      lightColorSaturation: GenericRgbwLightColorSaturation('1.0'),
      lightColorValue: GenericRgbwLightColorValue('1.0'),
    );

    return tuyaSmartDE;
  }
}
