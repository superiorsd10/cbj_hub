import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_s20/sonoff_s20_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

abstract class ISonoffS20Repository {
  // watch SonoffS20s
  // watch only a
  // CUD

  // C Read UD

  Future<void> initiateHubConnection();

  Future<void> manageHubRequestsForDevice(SonoffS20DE sonoffS20DE);

  Future<void> executeDeviceAction(SonoffS20DE sonoffS20DE);

  Future<Either<CoreFailure, KtList<SonoffS20DE?>>> getAllSonoffS20s();

  Future<Either<CoreFailure, KtList<SonoffS20Dtos?>>> getAllSonoffS20sAsDto();

  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchAll();

  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchLights();

  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchUncompleted();

  Future<Either<CoreFailure, Unit>> create(SonoffS20DE sonoffS20);

  /// Update document in the database in the following fields
  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> updateWithSonoffS20({
    required SonoffS20DE sonoffS20,
    String? forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> turnOnSonoffS20s(SonoffS20DE sonoffS20DE);

  Future<Either<CoreFailure, Unit>> turnOffSonoffS20s(SonoffS20DE sonoffS20DE);

  Future<Either<CoreFailure, Unit>> delete(SonoffS20DE sonoffS20);
}
