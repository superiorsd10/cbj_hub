import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';

class TuyaSmartSwitchEntity extends GenericSwitchDE {
  TuyaSmartSwitchEntity({
    required CoreUniqueId uniqueId,
    required VendorUniqueId vendorUniqueId,
    required DeviceDefaultName defaultName,
    required DeviceState deviceStateGRPC,
    required DeviceStateMassage stateMassage,
    required DeviceSenderDeviceOs senderDeviceOs,
    required DeviceSenderDeviceModel senderDeviceModel,
    required DeviceSenderId senderId,
    required DeviceCompUuid compUuid,
    required DevicePowerConsumption powerConsumption,
    required GenericSwitchState switchState,
    required this.tuyaSmartDeviceId,
  }) : super(
          uniqueId: uniqueId,
          vendorUniqueId: vendorUniqueId,
          defaultName: defaultName,
          switchState: switchState,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.tuyaSmart.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        );

  /// TuyaSmart device unique id that came withe the device
  TuyaSmartDeviceId? tuyaSmartDeviceId;

  /// TuyaSmart package object require to close previews request before new one
  Device? tuyaSmartPackageObject;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericSwitchDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    if (newEntity.switchState!.getOrCrash() != switchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
        newEntity.switchState!.getOrCrash(),
      );

      if (actionToPreform.toString() != switchState!.getOrCrash()) {
        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold(
            (l) => logger.e('Error turning tuya_smart light on\n$l'),
            (r) => logger.i('Light turn on success'),
          );
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
            (l) => logger.e('Error turning tuya_smart light off\n$l'),
            (r) => logger.i('Light turn off success'),
          );
        } else {
          logger.w(
            'actionToPreform is not set correctly on TuyaSmart JbtA70RgbcwWfEntity',
          );
        }
      }
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    switchState = GenericSwitchState(DeviceActions.on.toString());
    try {
      TuyaSmartConnectorConjector.cloudTuya.turnOn(
        tuyaSmartDeviceId!.getOrCrash(),
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    switchState = GenericSwitchState(DeviceActions.off.toString());

    try {
      TuyaSmartConnectorConjector.cloudTuya.turnOff(
        tuyaSmartDeviceId!.getOrCrash(),
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
