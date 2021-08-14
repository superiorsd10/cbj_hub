import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_led/tasmota_led_entity.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';

class Yeelight1SeDeviceActions {
  static Future<Either<CoreFailure, Unit>> turnOn(
      TasmotaLedEntity tasmotaLedEntity) async {
    //mqtt
    // cmnd/tasmota_D663A6/Power
    // payload
    // ON

    try {
      getIt<IMqttServerRepository>().publishMessage(
          'cmnd/${tasmotaLedEntity.tasmotaDeviceTopicName.getOrCrash()}/Power',
          'ON');
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  static Future<Either<CoreFailure, Unit>> turnOff(
      TasmotaLedEntity tasmotaLedEntity) async {
    try {
      getIt<IMqttServerRepository>().publishMessage(
          'cmnd/${tasmotaLedEntity.tasmotaDeviceTopicName.getOrCrash()}/Power',
          'OFF');
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
