import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';

class Yeelight1SeEntity extends GenericLightDE {
  Yeelight1SeEntity({
    required CoreUniqueId uniqueId,
    required CoreUniqueId roomId,
    required DeviceType deviceTypes,
    required DeviceDefaultName defaultName,
    DeviceRoomName? roomName,
    DeviceState? deviceStateGRPC,
    DeviceStateMassage? stateMassage,
    DeviceSenderDeviceOs? senderDeviceOs,
    DeviceSenderDeviceModel? senderDeviceModel,
    DeviceSenderId? senderId,
    DeviceAction? deviceActions,
    DeviceVendor? deviceVendor,
    DeviceCompUuid? compUuid,
    DeviceLastKnownIp? lastKnownIp,
    DevicePowerConsumption? powerConsumption,
    DeviceMdnsName? deviceMdnsName,
    DeviceSecondWiFiName? deviceSecondWiFi,
    GenericLightSwitchState? lightSwitchState,
    required this.yeelightDeviceId,
    required this.yeelightPort,
  }) : super(
          uniqueId: uniqueId,
          defaultName: defaultName,
          roomId: roomId,
          roomName: roomName,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceActions: deviceActions,
          deviceVendor: DeviceVendor(VendorsAndServices.yeelight.toString()),
          deviceTypes: deviceTypes,
          compUuid: compUuid,
          lastKnownIp: lastKnownIp,
          powerConsumption: powerConsumption,
          deviceMdnsName: deviceMdnsName,
          deviceSecondWiFi: deviceSecondWiFi,
        );

  /// Yeelight device unique id that came withe the device
  YeelightDeviceId? yeelightDeviceId;

  /// Yeelight communication port
  YeelightPort? yeelightPort;
}
