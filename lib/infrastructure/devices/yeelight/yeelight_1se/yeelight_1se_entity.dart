import 'dart:async';
import 'dart:io';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';

class Yeelight1SeEntity extends GenericRgbwLightDE {
  Yeelight1SeEntity({
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
    required GenericRgbwLightSwitchState lightSwitchState,
    required GenericRgbwLightColorTemperature lightColorTemperature,
    required GenericRgbwLightBrightness lightBrightness,
    required GenericRgbwLightColorAlpha lightColorAlpha,
    required GenericRgbwLightColorHue lightColorHue,
    required GenericRgbwLightColorSaturation lightColorSaturation,
    required GenericRgbwLightColorValue lightColorValue,
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
          lightColorTemperature: lightColorTemperature,
          lightBrightness: lightBrightness,
          lightColorAlpha: lightColorAlpha,
          lightColorHue: lightColorHue,
          lightColorSaturation: lightColorSaturation,
          lightColorValue: lightColorValue,
        );

  /// Yeelight device unique id that came withe the device
  YeelightDeviceId? yeelightDeviceId;

  /// Yeelight communication port
  YeelightPort? yeelightPort;

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName? deviceMdnsName;

  /// Yeelight package object require to close previews request before new one
  Device? yeelightPackageObject;

  /// Timer to execute methods with min of 1 seconds between each other
  Timer? executeStateTimer;

  /// How much time to wait between execute of methods
  /// TODO: Test if we can lower this number to 1000 and requests do not
  /// get denied
  final int sendNewRequestToDeviceEachMilliseconds = 1100;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
    DeviceEntityAbstract newEntity,
  ) async {
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
            (l) => logger.e('Error turning Yeelight light on\n$l'),
            (r) => logger.i('Yeelight light turn on success'),
          );
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold(
            (l) => logger.e('Error turning Yeelight light off\n$l'),
            (r) => logger.i('Yeelight light turn off success'),
          );
        } else {
          logger.i('actionToPreform is not set correctly on Yeelight 1SE');
        }
      }
    }

    if (newEntity.lightColorAlpha.getOrCrash() !=
            lightColorAlpha.getOrCrash() ||
        newEntity.lightColorHue.getOrCrash() != lightColorHue.getOrCrash() ||
        newEntity.lightColorSaturation.getOrCrash() !=
            lightColorSaturation.getOrCrash() ||
        newEntity.lightColorValue.getOrCrash() !=
            lightColorValue.getOrCrash()) {
      (await changeColorTemperature(
        lightColorAlphaNewValue: newEntity.lightColorAlpha.getOrCrash(),
        lightColorHueNewValue: newEntity.lightColorHue.getOrCrash(),
        lightColorSaturationNewValue:
            newEntity.lightColorSaturation.getOrCrash(),
        lightColorValueNewValue: newEntity.lightColorValue.getOrCrash(),
      ))
          .fold(
        (l) => logger.e('Error changing Yeelight light color\n$l'),
        (r) => logger.i('Yeelight changed color successfully'),
      );
    }

    if (newEntity.lightBrightness.getOrCrash() !=
        lightBrightness.getOrCrash()) {
      (await setBrightness(newEntity.lightBrightness.getOrCrash())).fold(
        (l) => logger.e('Error changing Yeelight brightness\n$l'),
        (r) => logger.i('Yeelight changed brightness successfully'),
      );
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericRgbwLightSwitchState(DeviceActions.on.toString());
    try {
      executeCurrentStatusWithConstDelay();
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
      executeCurrentStatusWithConstDelay();
      return right(unit);
    } catch (e) {
      return left(CoreFailure.actionExcecuter(failedValue: e));
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> setBrightness(String brightness) async {
    lightBrightness = GenericRgbwLightBrightness(brightness);

    try {
      executeCurrentStatusWithConstDelay();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> changeColorTemperature({
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
      executeCurrentStatusWithConstDelay();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  /// Yeelight connections are rate-limited to 60 per minute.
  /// This method will take care that commends will be sent in 1 second
  /// between each one
  Future<void> executeCurrentStatusWithConstDelay() async {
    executeStateTimer ??=
        Timer(Duration(milliseconds: sendNewRequestToDeviceEachMilliseconds),
            () async {
      try {
        try {
          // TODO: probably all the discovered device if changed IP can be
          //  written only once here and not in each device action we execute
          if (lightSwitchState?.getOrCrash() == DeviceActions.off.toString()) {
            await _sendTurnOffDevice();
          } else {
            await _sendTurnOnDevice();
            await _sendChangeColorTemperature();
            await _sendSetBrightness();
          }
        } catch (e) {
          logger.e('Error executing Yeelight current state\n$e');
        } finally {
          yeelightPackageObject?.disconnect();
        }
      } catch (e) {
        logger.e('Yeelight throws exception on disconnect\n$e');
      }
      executeStateTimer = null;
    });
  }

  /// Will turn off the device, will not close the connection
  Future<Either<CoreFailure, Unit>> _sendTurnOffDevice() async {
    try {
      yeelightPackageObject = Device(
        address: InternetAddress(lastKnownIp!.getOrCrash()),
        port: int.parse(yeelightPort!.getOrCrash()),
      );

      await yeelightPackageObject!.turnOff();
      return right(unit);
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 150));
      final responses = await Yeelight.discover();

      final response = responses.firstWhereOrNull(
        (element) => element.id.toString() == yeelightDeviceId!.getOrCrash(),
      );
      if (response == null) {
        logger.v('Device cant be discovered');
        return left(const CoreFailure.unableToUpdate());
      }

      yeelightPackageObject =
          Device(address: response.address, port: response.port!);

      lastKnownIp = DeviceLastKnownIp(response.address.address);
      yeelightPort = YeelightPort(response.port!.toString());

      await yeelightPackageObject!.turnOff();
    }
    return right(unit);
  }

  /// Will turn on the device, will not close the connection
  Future<Either<CoreFailure, Unit>> _sendTurnOnDevice() async {
    try {
      yeelightPackageObject = Device(
        address: InternetAddress(lastKnownIp!.getOrCrash()),
        port: int.parse(yeelightPort!.getOrCrash()),
      );

      await yeelightPackageObject!.turnOn();
      return right(unit);
    } catch (e) {
      /// TODO: Maybe can be removed, need testing
      await Future.delayed(const Duration(milliseconds: 150));
      final responses = await Yeelight.discover();

      final response = responses.firstWhereOrNull(
        (element) => element.id.toString() == yeelightDeviceId!.getOrCrash(),
      );
      if (response == null) {
        logger.v('Device cant be discovered');
        return left(const CoreFailure.unableToUpdate());
      }

      yeelightPackageObject =
          Device(address: response.address, port: response.port!);

      lastKnownIp = DeviceLastKnownIp(response.address.address);
      yeelightPort = YeelightPort(response.port!.toString());

      await yeelightPackageObject!.turnOn();
    }
    return right(unit);
  }

  Future<Either<CoreFailure, Unit>> _sendChangeColorTemperature() async {
    try {
      try {
        yeelightPackageObject = Device(
          address: InternetAddress(lastKnownIp!.getOrCrash()),
          port: int.parse(yeelightPort!.getOrCrash()),
        );

        // await device.setColorTemperature(
        //   colorTemperature: int.parse(
        //     lightColorTemperature!.getOrCrash(),
        //   ),
        // );
        int saturationValue;
        if (lightColorSaturation.getOrCrash().length <= 3 &&
            lightColorSaturation.getOrCrash() == '0.0') {
          saturationValue = 0;
        } else if (lightColorSaturation.getOrCrash().length <= 3) {
          saturationValue = 100;
        } else {
          saturationValue =
              int.parse(lightColorSaturation.getOrCrash().substring(2, 4));
        }

        await yeelightPackageObject!.setHSV(
          hue: double.parse(lightColorHue.getOrCrash()).toInt(),
          saturation: saturationValue,
          duration: const Duration(
            milliseconds: 100,
          ),
        );

        return right(unit);
      } catch (e) {
        await Future.delayed(const Duration(milliseconds: 150));

        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull(
          (element) => element.id.toString() == yeelightDeviceId!.getOrCrash(),
        );
        if (response == null) {
          logger.v('Device cant be discovered');
          return left(const CoreFailure.unableToUpdate());
        }

        yeelightPackageObject =
            Device(address: response.address, port: response.port!);
        lastKnownIp = DeviceLastKnownIp(response.address.address);
        yeelightPort = YeelightPort(response.port!.toString());

        // await device.setColorTemperature(
        //   colorTemperature: int.parse(
        //     lightColorTemperature!.getOrCrash(),
        //   ),
        // );

        int saturationValue;
        if (lightColorSaturation.getOrCrash().length <= 3 &&
            lightColorSaturation.getOrCrash() == '0.0') {
          saturationValue = 0;
        } else if (lightColorSaturation.getOrCrash().length <= 3) {
          saturationValue = 100;
        } else {
          saturationValue =
              int.parse(lightColorSaturation.getOrCrash().substring(2, 4));
        }

        await yeelightPackageObject!.setHSV(
          hue: double.parse(lightColorHue.getOrCrash()).toInt(),
          saturation: saturationValue,
          duration: const Duration(
            milliseconds: 100,
          ),
        );

        return right(unit);
      }
    } catch (e) {
      return left(CoreFailure.actionExcecuter(failedValue: e));
    }
  }

  Future<Either<CoreFailure, Unit>> _sendSetBrightness() async {
    try {
      try {
        yeelightPackageObject = Device(
          address: InternetAddress(lastKnownIp!.getOrCrash()),
          port: int.parse(yeelightPort!.getOrCrash()),
        );

        await yeelightPackageObject!.turnOn();

        await yeelightPackageObject!.setBrightness(
          brightness: int.parse(
            lightBrightness.getOrCrash(),
          ),
          duration: const Duration(milliseconds: 200),
        );

        yeelightPackageObject!.disconnect();

        return right(unit);
      } catch (e) {
        await Future.delayed(const Duration(milliseconds: 150));

        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull(
          (element) => element.id.toString() == yeelightDeviceId!.getOrCrash(),
        );
        if (response == null) {
          logger.v('Device cant be discovered');
          return left(const CoreFailure.unexpected());
        }

        yeelightPackageObject =
            Device(address: response.address, port: response.port!);
        lastKnownIp = DeviceLastKnownIp(response.address.address);
        yeelightPort = YeelightPort(response.port!.toString());

        await yeelightPackageObject!.turnOn();

        await yeelightPackageObject!.setBrightness(
          brightness: int.parse(
            lightBrightness.getOrCrash(),
          ),
          duration: const Duration(milliseconds: 200),
        );

        return right(unit);
      }
    } catch (error) {
      logger.e('Error in Yeelight Device\n$error');
      return left(const CoreFailure.unexpected());
    }
  }
}
