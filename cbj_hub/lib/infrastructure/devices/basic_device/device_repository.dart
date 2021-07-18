import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/domain/devices/basic_device/i_device_repository.dart';
import 'package:cbj_hub/infrastructure/devices/basic_device/device_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

class DeviceRepository implements IDeviceRepository {
  @override
  Future<Either<CoreFailure, Unit>> create(DeviceEntity deviceEntity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(DeviceEntity deviceEntity) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<DeviceEntity?>>> getAllDevices() {
    // TODO: implement getAllDevices
    throw UnimplementedError();
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> moveDownBlinds(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement moveDownBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> moveUpBlinds(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement moveUpBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> stopBlinds(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement stopBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffDevices(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement turnOffDevices
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnDevices(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement turnOnDevices
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> updateDatabase(
      {required String pathOfField,
      required Map<String, dynamic> fieldsToUpdate,
      String? forceUpdateLocation}) {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> updateWithDeviceEntity(
      {required DeviceEntity deviceEntity, String? forceUpdateLocation}) {
    // TODO: implement updateWithDeviceEntity
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchBlinds() {
    // TODO: implement watchBlinds
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchBoilers() {
    // TODO: implement watchBoilers
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchLights() {
    // TODO: implement watchLights
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<DeviceEntity?>>> watchUncompleted() {
    // TODO: implement watchUncompleted
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<DeviceDtos?>>> getAllDevicesAsDto() async {
    return right((await getAllDevices())
        .getOrElse(() => <DeviceEntity?>[].toImmutableList())
        .map((d) => DeviceDtos.fromDomain(d!)));
  }
}
