import 'dart:async';
import 'dart:io';

import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
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
    required this.yeelightDeviceId,
    required this.yeelightPort,
    this.deviceMdnsName,
    this.lastKnownIp,
    required GenericRgbwLightColorTemperature lightColorTemperature,
    required GenericRgbwLightBrightness lightBrightness,
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
        );

  /// Yeelight device unique id that came withe the device
  YeelightDeviceId? yeelightDeviceId;

  /// Yeelight communication port
  YeelightPort? yeelightPort;

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName? deviceMdnsName;

  /// Please override the following methods
  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction(
      DeviceEntityAbstract newEntity) async {
    if (newEntity is! GenericRgbwLightDE) {
      return left(const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type'));
    }

    if (newEntity.lightSwitchState!.getOrCrash() !=
        lightSwitchState!.getOrCrash()) {
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash());

      if (actionToPreform == DeviceActions.on) {
        (await turnOnLight()).fold((l) => print('Error turning light on'),
            (r) => print('Light turn on success'));
      } else if (actionToPreform == DeviceActions.off) {
        (await turnOffLight()).fold((l) => print('Error turning light off'),
            (r) => print('Light turn off success'));
      } else {
        print('actionToPreform is not set correctly');
      }
    }

    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    try {
      try {
        final device = Device(
            address: InternetAddress(lastKnownIp!.getOrCrash()),
            port: int.parse(yeelightPort!.getOrCrash()));

        device.adjustBrightness(
            percentage: int.parse(lightBrightness!.getOrCrash()),
            duration: const Duration(seconds: 50));
        // device.setBrightness(brightness: brightness)
        device.setColorTemperature(
            colorTemperature: int.parse(lightColorTemperature!.getOrCrash()));
        await device.turnOn();
        device.disconnect();

        return right(unit);
      } catch (e) {
        await Future.delayed(const Duration(milliseconds: 150));

        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull((element) =>
            element.id.toString() == yeelightDeviceId!.getOrCrash());
        if (response == null) {
          print('Device cant be discovered');
          return left(const CoreFailure.unexpected());
        }

        final device = Device(address: response.address, port: response.port!);
        lastKnownIp = DeviceLastKnownIp(response.address.address.toString());
        yeelightPort = YeelightPort(response.port!.toString());

        await device.turnOn();
        device.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    try {
      try {
        final device = Device(
            address: InternetAddress(lastKnownIp!.getOrCrash()),
            port: int.parse(yeelightPort!.getOrCrash()));

        await device.turnOff();
        device.disconnect();

        return right(unit);
      } catch (e) {
        await Future.delayed(const Duration(milliseconds: 150));
        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull((element) =>
            element.id.toString() == yeelightDeviceId!.getOrCrash());
        if (response == null) {
          print('Device cant be discovered');

          return left(const CoreFailure.unexpected());
        }

        final device = Device(address: response.address, port: response.port!);

        lastKnownIp = DeviceLastKnownIp(response.address.address.toString());
        yeelightPort = YeelightPort(response.port!.toString());

        await device.turnOff();
        device.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  static Future<Either<CoreFailure, Unit>> adjustBrightness(
      Yeelight1SeEntity yeelight1seEntity) async {
    try {
      try {
        final device = Device(
            address:
                InternetAddress(yeelight1seEntity.lastKnownIp!.getOrCrash()),
            port: int.parse(yeelight1seEntity.yeelightPort!.getOrCrash()));

        await device.adjustBrightness(
            percentage:
                int.parse(yeelight1seEntity.lightBrightness!.getOrCrash()),
            duration: const Duration(seconds: 50));

        device.disconnect();

        return right(unit);
      } catch (e) {
        await Future.delayed(const Duration(milliseconds: 150));

        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull((element) =>
            element.id.toString() ==
            yeelight1seEntity.yeelightDeviceId!.getOrCrash());
        if (response == null) {
          print('Device cant be discovered');
          return left(const CoreFailure.unexpected());
        }

        final device = Device(address: response.address, port: response.port!);
        yeelight1seEntity
          ..lastKnownIp = DeviceLastKnownIp(response.address.address.toString())
          ..yeelightPort = YeelightPort(response.port!.toString());

        await device.adjustBrightness(
            percentage:
                int.parse(yeelight1seEntity.lightBrightness!.getOrCrash()),
            duration: const Duration(seconds: 50));

        device.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  static Future<Either<CoreFailure, Unit>> changeColorTemperature(
      Yeelight1SeEntity yeelight1seEntity) async {
    try {
      try {
        final device = Device(
            address:
                InternetAddress(yeelight1seEntity.lastKnownIp!.getOrCrash()),
            port: int.parse(yeelight1seEntity.yeelightPort!.getOrCrash()));

        await device.setColorTemperature(
            colorTemperature: int.parse(
                yeelight1seEntity.lightColorTemperature!.getOrCrash()));
        device.disconnect();

        return right(unit);
      } catch (e) {
        await Future.delayed(const Duration(milliseconds: 150));

        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull((element) =>
            element.id.toString() ==
            yeelight1seEntity.yeelightDeviceId!.getOrCrash());
        if (response == null) {
          print('Device cant be discovered');
          return left(const CoreFailure.unexpected());
        }

        final device = Device(address: response.address, port: response.port!);
        yeelight1seEntity
          ..lastKnownIp = DeviceLastKnownIp(response.address.address.toString())
          ..yeelightPort = YeelightPort(response.port!.toString());

        await device.setColorTemperature(
            colorTemperature: int.parse(
                yeelight1seEntity.lightColorTemperature!.getOrCrash()));

        device.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
