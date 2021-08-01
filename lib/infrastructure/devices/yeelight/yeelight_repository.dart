import 'dart:async';

import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_entity.dart';
import 'package:cbj_hub/domain/devices/yeelight/i_yeelight_device_repository.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

class YeelightRepo implements IYeelightRepository {
  static Map<String, ESPHomeDE> espHomeDevices = {};

  @override
  Future<Either<CoreFailure, Unit>> create(YeelightDE yeelight) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(YeelightDE yeelight) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> executeDeviceAction(YeelightDE yeelightDE) {
    // TODO: implement executeDeviceAction
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<YeelightDE?>>> getAllYeelight() {
    // TODO: implement getAllYeelight
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<YeelightDtos?>>> getAllYeelightAsDto() {
    // TODO: implement getAllYeelightAsDto
    throw UnimplementedError();
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<void> manageHubRequestsForDevice(YeelightDE yeelightDE) {
    // TODO: implement manageHubRequestsForDevice
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffYeelight(YeelightDE yeelightDE) {
    // TODO: implement turnOffYeelight
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnYeelight(YeelightDE yeelightDE) {
    // TODO: implement turnOnESPHome
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> updateDatabase(
      {required String pathOfField,
      required Map<String, dynamic> fieldsToUpdate,
      String? forceUpdateLocation}) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> updateWithYeelight(
      {required YeelightDE yeelight, String? forceUpdateLocation}) {
    // TODO: implement updateWithYeelight
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<YeelightDE?>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<YeelightDE?>>> watchLights() {
    // TODO: implement watchLights
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<YeelightDE?>>> watchUncompleted() {
    // TODO: implement watchUncompleted
    throw UnimplementedError();
  }
}
