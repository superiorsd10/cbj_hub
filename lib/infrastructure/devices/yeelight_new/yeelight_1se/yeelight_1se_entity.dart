import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:dartz/dartz.dart';

class Yeelight1SeEntity implements GenericLightDE {
  @override
  // TODO: implement compUuid
  DeviceCompUuid? get compUuid => throw UnimplementedError();

  @override
  // TODO: implement copyWith
  $GenericLightDECopyWith<GenericLightDE> get copyWith =>
      throw UnimplementedError();

  @override
  // TODO: implement defaultName
  DeviceDefaultName? get defaultName => throw UnimplementedError();

  @override
  // TODO: implement deviceActions
  DeviceAction? get deviceActions => throw UnimplementedError();

  @override
  // TODO: implement deviceMdnsName
  DeviceMdnsName? get deviceMdnsName => throw UnimplementedError();

  @override
  // TODO: implement deviceSecondWiFi
  DeviceSecondWiFiName? get deviceSecondWiFi => throw UnimplementedError();

  @override
  // TODO: implement deviceStateGRPC
  DeviceState? get deviceStateGRPC => throw UnimplementedError();

  @override
  // TODO: implement deviceTypes
  DeviceType? get deviceTypes => throw UnimplementedError();

  @override
  // TODO: implement failureOption
  Option<CoreFailure> get failureOption => throw UnimplementedError();

  @override
  // TODO: implement genericLightSwitchKey
  GenericLightSwitchKey? get genericLightSwitchKey =>
      throw UnimplementedError();

  @override
  String getDeviceId() {
    // TODO: implement getDeviceId
    throw UnimplementedError();
  }

  @override
  // TODO: implement id
  CoreUniqueId? get id => throw UnimplementedError();

  @override
  // TODO: implement lastKnownIp
  DeviceLastKnownIp? get lastKnownIp => throw UnimplementedError();

  @override
  // TODO: implement powerConsumption
  DevicePowerConsumption? get powerConsumption => throw UnimplementedError();

  @override
  // TODO: implement roomId
  CoreUniqueId? get roomId => throw UnimplementedError();

  @override
  // TODO: implement roomName
  DeviceRoomName? get roomName => throw UnimplementedError();

  @override
  // TODO: implement senderDeviceModel
  DeviceSenderDeviceModel? get senderDeviceModel => throw UnimplementedError();

  @override
  // TODO: implement senderDeviceOs
  DeviceSenderDeviceOs? get senderDeviceOs => throw UnimplementedError();

  @override
  // TODO: implement senderId
  DeviceSenderId? get senderId => throw UnimplementedError();

  @override
  // TODO: implement stateMassage
  DeviceStateMassage? get stateMassage => throw UnimplementedError();

  /// Yeelight device unique id that came withe the device
  YeelightDeviceId? yeelightDeviceId;

  /// Yeelight communication port
  YeelightPort? yeelightPort;

  @override
  DeviceEntityDtoAbstract toInfrastructure() {
    // TODO: implement toInfrastructure
    throw UnimplementedError();
  }
}
