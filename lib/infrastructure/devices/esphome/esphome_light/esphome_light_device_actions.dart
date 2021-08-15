import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_api/esphome_api.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_entity.dart';
import 'package:dartz/dartz.dart';

class ESPHomeDeviceActions {
  static Future<Either<CoreFailure, Unit>> turnOn(
      ESPHomeLightEntity espHomeLightEntity) async {
    try {
      print('Turn on ESPHome device');
      EspHomeApi espHomeApi;
      try {
        espHomeApi = EspHomeApi.createWithAddress(
            espHomeLightEntity.deviceMdnsName.getOrCrash());
        //
        // EspHomeApi.listenToResponses();
        await espHomeApi.helloRequestToEsp();
      } catch (mDnsCannotBeFound) {
        espHomeApi = EspHomeApi.createWithAddress(
            espHomeLightEntity.lastKnownIp!.getOrCrash());
        //
        // EspHomeApi.listenToResponses();
        await espHomeApi.helloRequestToEsp();
      }
      await espHomeApi.sendConnect('MyPassword');
      // await EspHomeApi.deviceInfoRequestToEsp();
      // await EspHomeApi.listEntitiesRequest();
      // await EspHomeApi.subscribeStatesRequest();
      await espHomeApi.switchCommandRequest(
          int.parse(espHomeLightEntity.espHomeSwitchKey.getOrCrash()), true);
      await espHomeApi.disconnect();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  static Future<Either<CoreFailure, Unit>> turnOff(
      ESPHomeLightEntity espHomeLightEntity) async {
    try {
      try {
        print('Turn off ESPHome device');
        EspHomeApi espHomeApi;
        try {
          espHomeApi = EspHomeApi.createWithAddress(
              espHomeLightEntity.deviceMdnsName.getOrCrash());
          //
          // EspHomeApi.listenToResponses();
          await espHomeApi.helloRequestToEsp();
        } catch (mDnsCannotBeFound) {
          espHomeApi = EspHomeApi.createWithAddress(
              espHomeLightEntity.lastKnownIp!.getOrCrash());
          //
          // EspHomeApi.listenToResponses();
          await espHomeApi.helloRequestToEsp();
        }
        await espHomeApi.sendConnect('MyPassword');
        // await EspHomeApi.deviceInfoRequestToEsp();
        // await EspHomeApi.listEntitiesRequest();
        // await EspHomeApi.subscribeStatesRequest();
        await espHomeApi.switchCommandRequest(
            int.parse(espHomeLightEntity.espHomeSwitchKey.getOrCrash()), false);
        await espHomeApi.disconnect();
        return right(unit);
      } catch (exception) {
        return left(const CoreFailure.unexpected());
      }
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
