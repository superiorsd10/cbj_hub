import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/cloudtuya.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class TuyaSmartJbtA70RgbcwWfEntity extends GenericRgbwLightDE {
  TuyaSmartJbtA70RgbcwWfEntity({
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
    required GenericRgbwLightSwitchState lightSwitchState,
    required GenericRgbwLightColorTemperature lightColorTemperature,
    required GenericRgbwLightBrightness lightBrightness,
    required GenericRgbwLightColorAlpha lightColorAlpha,
    required GenericRgbwLightColorHue lightColorHue,
    required GenericRgbwLightColorSaturation lightColorSaturation,
    required GenericRgbwLightColorValue lightColorValue,
    required this.cloudTuya,
  }) : super(
          uniqueId: uniqueId,
          vendorUniqueId: vendorUniqueId,
          defaultName: defaultName,
          lightSwitchState: lightSwitchState,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.tuyaSmart.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
          lightColorTemperature: lightColorTemperature,
          lightBrightness: lightBrightness,
          lightColorAlpha: lightColorAlpha,
          lightColorHue: lightColorHue,
          lightColorSaturation: lightColorSaturation,
          lightColorValue: lightColorValue,
        );

  /// Will be the cloud api reference, can be Tuya or Jinvoo Smart or Smart Life
  CloudTuya cloudTuya;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericRgbwLightDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    if (newEntity.lightSwitchState!.getOrCrash() !=
        lightSwitchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
        newEntity.lightSwitchState!.getOrCrash(),
      );

      if (actionToPreform.toString() != lightSwitchState!.getOrCrash()) {
        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold(
            (l) => logger.e('Error turning Tuya light on\n$l'),
            (r) => logger.d('Tuya light turn on success'),
          );
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
            (l) => logger.e('Error turning Tuya light off\n$l'),
            (r) => logger.d('Tuya light turn off success'),
          );
        } else {
          logger.w(
            'actionToPreform is not set correctly on TuyaSmart'
            ' JbtA70RgbcwWfEntity',
          );
        }
      }
    }

    if (newEntity.lightColorTemperature.getOrCrash() !=
        lightColorTemperature.getOrCrash()) {
      (await changeColorTemperature(
        lightColorTemperatureNewValue:
            newEntity.lightColorTemperature.getOrCrash(),
      ))
          .fold(
        (l) => logger.e('Error changing Tuya temperature\n$l'),
        (r) => logger.i('Tuya changed temperature successfully'),
      );
    }

    if (newEntity.lightColorAlpha.getOrCrash() !=
            lightColorAlpha.getOrCrash() ||
        newEntity.lightColorHue.getOrCrash() != lightColorHue.getOrCrash() ||
        newEntity.lightColorSaturation.getOrCrash() !=
            lightColorSaturation.getOrCrash() ||
        newEntity.lightColorValue.getOrCrash() !=
            lightColorValue.getOrCrash()) {
      (await changeColorHsv(
        lightColorAlphaNewValue: newEntity.lightColorAlpha.getOrCrash(),
        lightColorHueNewValue: newEntity.lightColorHue.getOrCrash(),
        lightColorSaturationNewValue:
            newEntity.lightColorSaturation.getOrCrash(),
        lightColorValueNewValue: newEntity.lightColorValue.getOrCrash(),
      ))
          .fold(
        (l) => logger.e('Error changing Tuya light color\n$l'),
        (r) => logger.i('Light changed color successfully'),
      );
    }

    if (newEntity.lightBrightness.getOrCrash() !=
        lightBrightness.getOrCrash()) {
      (await setBrightness(newEntity.lightBrightness.getOrCrash())).fold(
        (l) => logger.e('Error changing Tuya brightness\n$l'),
        (r) => logger.i('Tuya changed brightness successfully'),
      );
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericRgbwLightSwitchState(DeviceActions.on.toString());
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
    lightSwitchState =
        GenericRgbwLightSwitchState(DeviceActions.off.toString());

    try {
      cloudTuya.turnOff(
        vendorUniqueId.getOrCrash(),
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> setBrightness(String brightness) async {
    lightBrightness = GenericRgbwLightBrightness(brightness);

    try {
      cloudTuya.setBrightness(
        vendorUniqueId.getOrCrash(),
        lightBrightness.getOrCrash(),
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> changeColorTemperature({
    required String lightColorTemperatureNewValue,
  }) async {
    lightColorTemperature =
        GenericRgbwLightColorTemperature(lightColorTemperatureNewValue);

    try {
      cloudTuya.setColorTemperature(
        deviceId: vendorUniqueId.getOrCrash(),
        newTemperature: lightColorTemperatureNewValue,
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> changeColorHsv({
    required String lightColorAlphaNewValue,
    required String lightColorHueNewValue,
    required String lightColorSaturationNewValue,
    required String lightColorValueNewValue,
  }) async {
    lightColorAlpha = GenericRgbwLightColorAlpha(lightColorAlphaNewValue);
    lightColorHue = GenericRgbwLightColorHue(lightColorHueNewValue);
    lightColorSaturation =
        GenericRgbwLightColorSaturation(lightColorSaturationNewValue);
    lightColorValue = GenericRgbwLightColorValue(lightColorValueNewValue);

    try {
      cloudTuya.setColorHsv(
        deviceId: vendorUniqueId.getOrCrash(),
        hue: lightColorHue.getOrCrash(),
        saturation: lightColorSaturation.getOrCrash(),
        brightness: lightBrightness.getOrCrash(),
      );
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
