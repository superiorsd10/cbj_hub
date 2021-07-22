import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/basic_device/device_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

abstract class IDeviceRepository {
  // watch devices
  // watch only a
  // CUD

  // C Read UD

  Future<void> initiateHubConnection();

  Future<void> manageHubRequestsForDevice();

  Future<Either<CoreFailure, KtList<DeviceEntity?>>> getAllDevices();

  Future<Either<CoreFailure, KtList<DeviceDtos?>>> getAllDevicesAsDto();

  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchAll();

  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchLights();

  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchBlinds();

  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchBoilers();

  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchUncompleted();

  Future<Either<CoreFailure, Unit>> create(DeviceEntity deviceEntity);

  /// Update document in the database in the following fields
  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> updateWithDeviceEntity({
    required DeviceEntity deviceEntity,
    String? forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> turnOnDevices({
    required List<String>? devicesId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> turnOffDevices({
    required List<String>? devicesId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> moveUpBlinds({
    required List<String>? devicesId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> stopBlinds({
    required List<String>? devicesId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> moveDownBlinds({
    required List<String>? devicesId,
    String forceUpdateLocation,
  });

  Future<Either<CoreFailure, Unit>> delete(DeviceEntity deviceEntity);
}
