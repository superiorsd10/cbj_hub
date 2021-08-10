import 'dart:async';
import 'dart:io';

import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_1se_entity.dart';
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

        await device.turnOn();
        device.disconnect();

        return right(unit);
      } catch (e) {
        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull((element) =>
            element.id.toString() ==
            yeelight1seEntity.yeelightDeviceId!.getOrCrash());
        if (response == null) {
          return left(const CoreFailure.unexpected());
        }

        final device = Device(address: response.address, port: response.port!);

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
        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull((element) =>
            element.id.toString() ==
            yeelight1seEntity.yeelightDeviceId!.getOrCrash());
        if (response == null) {
          return left(const CoreFailure.unexpected());
        }

        final device = Device(address: response.address, port: response.port!);

        await device.turnOff();
        device.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
