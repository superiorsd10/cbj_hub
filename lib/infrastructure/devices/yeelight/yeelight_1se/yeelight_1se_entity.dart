import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';

class Yeelight1SeEntity extends GenericLightDE {
  Yeelight1SeEntity({
    required CoreUniqueId uniqueId,
    required CoreUniqueId roomId,
    required DeviceType deviceTypes,
    required DeviceDefaultName defaultName,
    required DeviceRoomName roomName,
    required DeviceState deviceStateGRPC,
    required DeviceStateMassage stateMassage,
    required DeviceSenderDeviceOs senderDeviceOs,
    required DeviceSenderDeviceModel senderDeviceModel,
    required DeviceSenderId senderId,
    required DeviceAction deviceActions,
    required DeviceCompUuid compUuid,
    required DevicePowerConsumption powerConsumption,
    required DeviceSecondWiFiName deviceSecondWiFi,
    required GenericLightSwitchState lightSwitchState,
    required this.yeelightDeviceId,
    required this.yeelightPort,
    this.deviceMdnsName,
    this.lastKnownIp,
  }) : super(
          uniqueId: uniqueId,
          defaultName: defaultName,
          roomId: roomId,
          lightSwitchState: lightSwitchState,
          roomName: roomName,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.yeelight.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        );

  /// Yeelight device unique id that came withe the device
  YeelightDeviceId? yeelightDeviceId;

  /// Yeelight communication port
  YeelightPort? yeelightPort;

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName? deviceMdnsName;
}
