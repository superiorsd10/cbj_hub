import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/cloudtuya.dart';
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
    required GenericLightSwitchState switchState,
    required this.cloudTuya,
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

  /// TuyaSmart package object require to close previews request before new one
  Device? tuyaSmartPackageObject;

  /// Will be the cloud api reference, can be Tuya or Jinvoo Smart or Smart Life
  CloudTuya cloudTuya;

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

    if (newEntity.switchState!.getOrCrash() != switchState!.getOrCrash() ||
        deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
        newEntity.switchState!.getOrCrash(),
      );

      if (actionToPreform == DeviceActions.on) {
        (await turnOnLight()).fold(
          (l) {
            logger.e('Error turning Tuya switch on\n$l');
            deviceStateGRPC =
                DeviceState(DeviceStateGRPC.newStateFailed.toString());
          },
          (r) {
            logger.i('Tuya switch turn on success');
            deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
          },
        );
      } else if (actionToPreform == DeviceActions.off) {
        (await turnOffLight()).fold(
          (l) {
            logger.e('Error turning Tuya off\n$l');
            deviceStateGRPC =
                DeviceState(DeviceStateGRPC.newStateFailed.toString());
          },
          (r) {
            logger.i('Tuya switch turn off success');
            deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
          },
        );
      } else {
        logger.w(
          'actionToPreform is not set correctly on TuyaSmart JbtA70RgbcwWfEntity',
        );
      }
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    switchState = GenericLightSwitchState(DeviceActions.on.toString());
    try {
      cloudTuya.turnOn(
        vendorUniqueId.getOrCrash(),
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    switchState = GenericLightSwitchState(DeviceActions.off.toString());

    try {
      cloudTuya.turnOff(
        vendorUniqueId.getOrCrash(),
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
