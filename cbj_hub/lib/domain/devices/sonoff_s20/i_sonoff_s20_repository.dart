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

  Future<Either<CoreFailure, KtList<SonoffS20DE?>>> getAllSonoffS20s();

  Future<Either<CoreFailure, KtList<SonoffS20Dtos?>>> getAllSonoffS20sAsDto();

  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchAll();

  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchLights();

  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchBlinds();

  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchBoilers();

  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchUncompleted();

  Future<Either<CoreFailure, Unit>> create(SonoffS20DE SonoffS20);

  /// Update document in the database in the following fields
  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> updateWithSonoffS20({
    required SonoffS20DE SonoffS20,
    String? forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> turnOnSonoffS20s({
    required List<String>? SonoffS20sId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> turnOffSonoffS20s({
    required List<String>? SonoffS20sId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> moveUpBlinds({
    required List<String>? SonoffS20sId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> stopBlinds({
    required List<String>? SonoffS20sId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> moveDownBlinds({
    required List<String>? SonoffS20sId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> delete(SonoffS20DE SonoffS20);
}
