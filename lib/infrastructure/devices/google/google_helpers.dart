import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/google/chrome_cast/chrome_cast_entity.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:yeedart/yeedart.dart';

class GoogleHelpers {
  static DeviceEntityAbstract addDiscoverdDevice(
    DiscoveryResponse yeelightDevice,
  ) {
    final ChromeCastEntity yeelightDE = ChromeCastEntity(
      uniqueId: CoreUniqueId(),
      defaultName: DeviceDefaultName('Google test 2'),
      roomId: CoreUniqueId.newDevicesRoom(),
      roomName: DeviceRoomName(' '),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('yeelight'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
      lastKnownIp: DeviceLastKnownIp(yeelightDevice.address.address),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      googleDeviceId: GoogleDeviceId(yeelightDevice.id.toString()),
      googlePort: GooglePort(yeelightDevice.port.toString()),
      smartTvSwitchState: GenericSmartTvSwitchState(
        DeviceActions.actionNotSupported.toString(),
      ),
    );

    return yeelightDE;
  }
}
