import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/old/esphome_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

abstract class IESPHomeRepository {
  // watch ESPHome
  // watch only a
  // CUD

  // C Read UD

  Future<void> initiateHubConnection();

  Future<void> manageHubRequestsForDevice(ESPHomeDE espHomeDE);

  Future<void> executeDeviceAction(ESPHomeDE espHomeDE);

  Future<Either<CoreFailure, KtList<ESPHomeDE?>>> getAllESPHome();

  Future<Either<CoreFailure, KtList<EspHomeDtos?>>> getAllESPHomeAsDto();

  Stream<Either<CoreFailure, KtList<ESPHomeDE?>>> watchAll();

  Stream<Either<CoreFailure, KtList<ESPHomeDE?>>> watchLights();

  Stream<Either<CoreFailure, KtList<ESPHomeDE?>>> watchUncompleted();

  Future<Either<CoreFailure, Unit>> create(ESPHomeDE espHome);

  /// Update document in the database in the following fields
  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> updateWithESPHome({
    required ESPHomeDE espHome,
    String? forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> turnOnESPHome(ESPHomeDE espHomeDE);

  Future<Either<CoreFailure, Unit>> turnOffESPHome(ESPHomeDE espHomeDE);

  Future<Either<CoreFailure, Unit>> delete(ESPHomeDE espHome);
}
