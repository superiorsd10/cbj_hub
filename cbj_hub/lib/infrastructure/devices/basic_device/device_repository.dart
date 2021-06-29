import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/domain/devices/basic_device/devices_failures.dart';
import 'package:cbj_hub/domain/devices/basic_device/i_device_repository.dart';
import 'package:cbj_hub/infrastructure/devices/basic_device/device_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

class DeviceRepository implements IDeviceRepository {
  @override
  Future<Either<DevicesFailure, Unit>> create(DeviceEntity deviceEntity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, Unit>> delete(DeviceEntity deviceEntity) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, KtList<DeviceEntity?>>> getAllDevices() {
    // TODO: implement getAllDevices
    throw UnimplementedError();
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, Unit>> moveDownBlinds(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement moveDownBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, Unit>> moveUpBlinds(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement moveUpBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, Unit>> stopBlinds(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement stopBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, Unit>> turnOffDevices(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement turnOffDevices
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, Unit>> turnOnDevices(
      {required List<String>? devicesId, String? forceUpdateLocation}) {
    // TODO: implement turnOnDevices
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, Unit>> updateDatabase(
      {required String pathOfField,
      required Map<String, dynamic> fieldsToUpdate,
      String? forceUpdateLocation}) {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, Unit>> updateWithDeviceEntity(
      {required DeviceEntity deviceEntity, String? forceUpdateLocation}) {
    // TODO: implement updateWithDeviceEntity
    throw UnimplementedError();
  }

  @override
  Stream<Either<DevicesFailure, KtList<DeviceEntity?>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

  @override
  Stream<Either<DevicesFailure, KtList<DeviceEntity?>>> watchBlinds() {
    // TODO: implement watchBlinds
    throw UnimplementedError();
  }

  @override
  Stream<Either<DevicesFailure, KtList<DeviceEntity?>>> watchBoilers() {
    // TODO: implement watchBoilers
    throw UnimplementedError();
  }

  @override
  Stream<Either<DevicesFailure, KtList<DeviceEntity?>>> watchLights() {
    // TODO: implement watchLights
    throw UnimplementedError();
  }

  @override
  Stream<Either<DevicesFailure, KtList<DeviceEntity?>>> watchUncompleted() {
    // TODO: implement watchUncompleted
    throw UnimplementedError();
  }

  @override
  Future<Either<DevicesFailure, KtList<DeviceDtos?>>>
      getAllDevicesAsDto() async {
    return right((await getAllDevices())
        .getOrElse(() => <DeviceEntity?>[].toImmutableList())
        .map((d) => DeviceDtos.fromDomain(d!)));
  }
}
