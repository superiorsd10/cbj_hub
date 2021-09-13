import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips%20hue/philips_hue_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/philips%20hue/philips_hue_e26/philips_hue_e26_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:yeedart/yeedart.dart';

class PhilipsHueHelpers {
  static DeviceEntityAbstract addDiscoverdDevice(
      DiscoveryResponse philips_hueDevice) {
    final PhilipsHueE26Entity philips_hueDE = PhilipsHueE26Entity(
      uniqueId: CoreUniqueId(),
      defaultName: DeviceDefaultName(
        philips_hueDevice.name != ''
            ? philips_hueDevice.name
            : 'PhilipsHue test 2',
      ),
      roomId: CoreUniqueId.newDevicesRoom(),
      roomName: DeviceRoomName('Discovered'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('philips_hue'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
      lastKnownIp: DeviceLastKnownIp(philips_hueDevice.address.address),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      philips_hueDeviceId: PhilipsHueDeviceId(philips_hueDevice.id.toString()),
      philips_huePort: PhilipsHuePort(philips_hueDevice.port.toString()),
      lightSwitchState:
          GenericRgbwLightSwitchState(philips_hueDevice.powered.toString()),
      lightColorTemperature: GenericRgbwLightColorTemperature(
        philips_hueDevice.colorTemperature.toString(),
      ),
      lightBrightness:
          GenericRgbwLightBrightness(philips_hueDevice.brightness.toString()),
      lightColorAlpha: GenericRgbwLightColorAlpha('1.0'),
      lightColorHue: GenericRgbwLightColorHue('0.0'),
      lightColorSaturation: GenericRgbwLightColorSaturation('1.0'),
      lightColorValue: GenericRgbwLightColorValue('1.0'),
    );

    return philips_hueDE;
  }
}
