import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/tasmota_device/tasmota_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

abstract class ITasmotaRepository {
  // watch Tasmota
  // watch only a
  // CUD

  // C Read UD

  Future<void> initiateHubConnection();

  Future<void> manageHubRequestsForDevice(TasmotaDE tasmotaDE);

  Future<void> executeDeviceAction(TasmotaDE tasmotaDE);

  Future<Either<CoreFailure, KtList<TasmotaDE?>>> getAllTasmota();

  Future<Either<CoreFailure, KtList<TasmotaDtos?>>> getAllTasmotaAsDto();

  Stream<Either<CoreFailure, KtList<TasmotaDE?>>> watchAll();

  Stream<Either<CoreFailure, KtList<TasmotaDE?>>> watchLights();

  Stream<Either<CoreFailure, KtList<TasmotaDE?>>> watchUncompleted();

  Future<Either<CoreFailure, Unit>> create(TasmotaDE tasmota);

  /// Update document in the database in the following fields
  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> updateWithTasmota({
    required TasmotaDE tasmota,
    String? forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> turnOnTasmota(TasmotaDE tasmotaDE);

  Future<Either<CoreFailure, Unit>> turnOffTasmota(TasmotaDE tasmotaDE);

  Future<Either<CoreFailure, Unit>> delete(TasmotaDE tasmota);
}
