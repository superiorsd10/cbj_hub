import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_boiler_device/generic_boiler_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';

class SwitcherV2Entity extends GenericBoilerDE {
  SwitcherV2Entity({
    required CoreUniqueId uniqueId,
    required CoreUniqueId roomId,
    required DeviceDefaultName defaultName,
    required DeviceRoomName roomName,
    required DeviceState deviceStateGRPC,
    required DeviceStateMassage stateMassage,
    required DeviceSenderDeviceOs senderDeviceOs,
    required DeviceSenderDeviceModel senderDeviceModel,
    required DeviceSenderId senderId,
    required DeviceCompUuid compUuid,
    required DevicePowerConsumption powerConsumption,
    required GenericBoilerSwitchState boilerSwitchState,
    required this.switcherDeviceId,
    this.switcherPort,
    this.lastKnownIp,
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
          deviceVendor: DeviceVendor(VendorsAndServices.switcher.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
          boilerSwitchState: boilerSwitchState,
        );

  /// Switcher device unique id that came withe the device
  SwitcherDeviceId? switcherDeviceId;

  /// Switcher communication port
  SwitcherPort? switcherPort;

  DeviceLastKnownIp? lastKnownIp;

  /// Switcher package object require to close previews request before new one
  Device? device;

  String? autoShutdown;
  String? electricCurrent;
  String? lastDataUpdate;
  String? macAddress;
  String? remainingTime;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
      DeviceEntityAbstract newEntity) async {
    if (newEntity is! GenericBoilerDE) {
      return left(const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type'));
    }

    if (newEntity.boilerSwitchState!.getOrCrash() !=
        boilerSwitchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          newEntity.boilerSwitchState!.getOrCrash());

      if (actionToPreform.toString() != boilerSwitchState!.getOrCrash()) {
        if (actionToPreform == DeviceActions.on) {
          (await turnOnBoiler()).fold((l) => print('Error turning boiler on'),
              (r) => print('Boiler turn on success'));
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffBoiler()).fold((l) => print('Error turning boiler off'),
              (r) => print('Boiler turn off success'));
        } else {
          print('actionToPreform is not set correctly');
        }
      }
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnBoiler() async {
    boilerSwitchState = GenericBoilerSwitchState(DeviceActions.on.toString());

    try {} catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return left(const CoreFailure.unexpected());
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffBoiler() async {
    boilerSwitchState = GenericBoilerSwitchState(DeviceActions.off.toString());

    try {} catch (e) {
      return left(const CoreFailure.unexpected());
    }
    return left(const CoreFailure.unexpected());
  }
}
