import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_white/lifx_white_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:lifx_http_api/lifx_http_api.dart' as lifx;
import 'package:lifx_http_api/lifx_http_api.dart';

class LifxHelpers {
  static DeviceEntityAbstract addDiscoverdDevice(
    lifx.Bulb lifxDevice,
  ) {
    final LifxWhiteEntity lifxDE = LifxWhiteEntity(
      uniqueId: CoreUniqueId(),
      vendorUniqueId: VendorUniqueId.fromUniqueString(lifxDevice.id),
      defaultName: DeviceDefaultName(
        lifxDevice.label != '' ? lifxDevice.label : 'Lifx test 2',
      ),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('Lifx'),
      senderDeviceModel: DeviceSenderDeviceModel('Cloud'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid(lifxDevice.uuid),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      lifxDeviceId: LifxDeviceId(lifxDevice.id),
      lightSwitchState: GenericLightSwitchState(
        (lifxDevice.power == LifxPower.on).toString(),
      ),
    );

    return lifxDE;
  }
}
