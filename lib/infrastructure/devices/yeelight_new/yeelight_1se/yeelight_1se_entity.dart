import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';

class Yeelight1SeEntity extends GenericLightDE {
  Yeelight1SeEntity({
    required this.uniqueId,
    required this.defaultName,
    required this.roomId,
    required this.roomName,
    required this.deviceStateGRPC,
    required this.stateMassage,
    required this.senderDeviceOs,
    required this.senderDeviceModel,
    required this.senderId,
    required this.deviceActions,
    required this.deviceTypes,
    required this.compUuid,
    required this.lastKnownIp,
    this.powerConsumption,
    this.deviceMdnsName,
    this.deviceSecondWiFi,
    this.genericLightSwitchKey,
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
          genericLightSwitchKey: genericLightSwitchKey,
        );

  /// Yeelight device unique id that came withe the device
  YeelightDeviceId? yeelightDeviceId;

  /// Yeelight communication port
  YeelightPort? yeelightPort;

  @override
  DeviceCompUuid? compUuid;

  @override
  DeviceDefaultName? defaultName;

  @override
  DeviceAction? deviceActions;

  @override
  DeviceMdnsName? deviceMdnsName;

  @override
  DeviceSecondWiFiName? deviceSecondWiFi;

  @override
  DeviceState? deviceStateGRPC;

  @override
  DeviceType? deviceTypes;

  @override
  GenericLightSwitchKey? genericLightSwitchKey;

  @override
  DeviceLastKnownIp? lastKnownIp;

  @override
  DevicePowerConsumption? powerConsumption;

  @override
  CoreUniqueId? roomId;

  @override
  DeviceRoomName? roomName;

  @override
  DeviceSenderDeviceModel? senderDeviceModel;

  @override
  DeviceSenderDeviceOs? senderDeviceOs;

  @override
  DeviceSenderId? senderId;

  @override
  DeviceStateMassage? stateMassage;

  @override
  CoreUniqueId? uniqueId;
}
