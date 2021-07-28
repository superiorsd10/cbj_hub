import 'dart:async';

import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_entity.dart';
import 'package:cbj_hub/domain/devices/tasmota_device/i_tasmota_device_repository.dart';
import 'package:cbj_hub/domain/devices/tasmota_device/tasmota_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

class TasmotaRepo implements ITasmotaRepository {
  static Map<String, ESPHomeDE> espHomeDevices = {};

  @override
  Future<Either<CoreFailure, Unit>> create(TasmotaDE tasmota) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(TasmotaDE tasmota) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> executeDeviceAction(TasmotaDE tasmotaDE) {
    // TODO: implement executeDeviceAction
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<TasmotaDE?>>> getAllTasmota() {
    // TODO: implement getAllTasmota
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<TasmotaDtos?>>> getAllTasmotaAsDto() {
    // TODO: implement getAllTasmotaAsDto
    throw UnimplementedError();
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<void> manageHubRequestsForDevice(TasmotaDE tasmotaDE) {
    // TODO: implement manageHubRequestsForDevice
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffTasmota(TasmotaDE tasmotaDE) {
    // TODO: implement turnOffTasmota
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnTasmota(TasmotaDE tasmotaDE) {
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
  Future<Either<CoreFailure, Unit>> updateWithTasmota(
      {required TasmotaDE tasmota, String? forceUpdateLocation}) {
    // TODO: implement updateWithTasmota
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<TasmotaDE?>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<TasmotaDE?>>> watchLights() {
    // TODO: implement watchLights
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<TasmotaDE?>>> watchUncompleted() {
    // TODO: implement watchUncompleted
    throw UnimplementedError();
  }
}
