import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

abstract class IYeelightRepository {
  // watch Yeelight
  // watch only a
  // CUD

  // C Read UD

  Future<void> initiateHubConnection();

  Future<void> manageHubRequestsForDevice(YeelightDE yeelightDE);

  Future<void> executeDeviceAction(YeelightDE yeelightDE);

  Future<Either<CoreFailure, KtList<YeelightDE?>>> getAllYeelight();

  Future<Either<CoreFailure, KtList<YeelightDtos?>>> getAllYeelightAsDto();

  Stream<Either<CoreFailure, KtList<YeelightDE?>>> watchAll();

  Stream<Either<CoreFailure, KtList<YeelightDE?>>> watchLights();

  Stream<Either<CoreFailure, KtList<YeelightDE?>>> watchUncompleted();

  Future<Either<CoreFailure, Unit>> create(YeelightDE yeelight);

  /// Update document in the database in the following fields
  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> updateWithYeelight({
    required YeelightDE yeelight,
    String? forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> turnOnYeelight(YeelightDE yeelightDE);

  Future<Either<CoreFailure, Unit>> turnOffYeelight(YeelightDE yeelightDE);

  Future<Either<CoreFailure, Unit>> delete(YeelightDE yeelight);
}
