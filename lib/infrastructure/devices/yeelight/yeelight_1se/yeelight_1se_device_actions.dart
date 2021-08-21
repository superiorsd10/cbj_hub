import 'dart:async';
import 'dart:io';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_1se_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_device_value_objects.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:yeedart/yeedart.dart';

class Yeelight1SeDeviceActions {
  static Future<Either<CoreFailure, Unit>> turnOn(
      Yeelight1SeEntity yeelight1seEntity) async {
    try {
      try {
        final device = Device(
            address:
                InternetAddress(yeelight1seEntity.lastKnownIp!.getOrCrash()),
            port: int.parse(yeelight1seEntity.yeelightPort!.getOrCrash()));

        device.adjustBrightness(
            percentage:
                int.parse(yeelight1seEntity.lightBrightness!.getOrCrash()),
            duration: const Duration(seconds: 50));
        // device.setBrightness(brightness: brightness)
        device.setColorTemperature(
            colorTemperature: int.parse(
                yeelight1seEntity.lightColorTemperature!.getOrCrash()));
        await device.turnOn();
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

        await device.turnOn();
        device.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  static Future<Either<CoreFailure, Unit>> turnOff(
      Yeelight1SeEntity yeelight1seEntity) async {
    try {
      try {
        final device = Device(
            address:
                InternetAddress(yeelight1seEntity.lastKnownIp!.getOrCrash()),
            port: int.parse(yeelight1seEntity.yeelightPort!.getOrCrash()));

        await device.turnOff();
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
