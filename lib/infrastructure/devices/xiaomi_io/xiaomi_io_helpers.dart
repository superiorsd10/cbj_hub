import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_gpx3021gl/xiaomi_io_gpx3021gl_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:yeedart/yeedart.dart';

class XiaomiIoHelpers {
  static DeviceEntityAbstract addDiscoverdDevice(
      DiscoveryResponse xiaomi_ioDevice) {
    final XiaomiIoGpx4021GlEntity xiaomi_ioDE = XiaomiIoGpx4021GlEntity(
      uniqueId: CoreUniqueId(),
      defaultName: DeviceDefaultName(
        xiaomi_ioDevice.name != '' ? xiaomi_ioDevice.name : 'XiaomiIo test 2',
      ),
      roomId: CoreUniqueId.newDevicesRoom(),
      roomName: DeviceRoomName('Discovered'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('xiaomi_io'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
      lastKnownIp: DeviceLastKnownIp(xiaomi_ioDevice.address.address),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      xiaomi_ioDeviceId: XiaomiIoDeviceId(xiaomi_ioDevice.id.toString()),
      xiaomi_ioPort: XiaomiIoPort(xiaomi_ioDevice.port.toString()),
      lightSwitchState:
          GenericRgbwLightSwitchState(xiaomi_ioDevice.powered.toString()),
      lightColorTemperature: GenericRgbwLightColorTemperature(
        xiaomi_ioDevice.colorTemperature.toString(),
      ),
      lightBrightness:
          GenericRgbwLightBrightness(xiaomi_ioDevice.brightness.toString()),
      lightColorAlpha: GenericRgbwLightColorAlpha('1.0'),
      lightColorHue: GenericRgbwLightColorHue('0.0'),
      lightColorSaturation: GenericRgbwLightColorSaturation('1.0'),
      lightColorValue: GenericRgbwLightColorValue('1.0'),
    );

    return xiaomi_ioDE;
  }
}
