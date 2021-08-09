import 'dart:async';

import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_entity.dart';
import 'package:cbj_hub/domain/devices/esphome_device/i_esphome_device_repository.dart';
import 'package:cbj_hub/infrastructure/aioesphomeapi/aioesphomeapi.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/old/esphome_dtos.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbenum.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

class ESPHomeRepo implements IESPHomeRepository {
  static Map<String, ESPHomeDE> espHomeDevices = {};

  @override
  Future<Either<CoreFailure, Unit>> delete(ESPHomeDE espHome) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<ESPHomeDE?>>> getAllESPHome() {
    // TODO: implement getAllESPHome
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<EspHomeDtos?>>> getAllESPHomeAsDto() {
    // TODO: implement getAllESPHomeAsDto
    throw UnimplementedError();
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> moveDownBlinds(
      {required List<String>? espHomesId, String? forceUpdateLocation}) {
    // TODO: implement moveDownBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> moveUpBlinds(
      {required List<String>? espHomesId, String? forceUpdateLocation}) {
    // TODO: implement moveUpBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> stopBlinds(
      {required List<String>? espHomesId, String? forceUpdateLocation}) {
    // TODO: implement stopBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffESPHome(ESPHomeDE espHomeDE) async {
    try {
      print('Turn off ESPHome device');
      AioEspHomeApi aioEspHomeApi;
      try {
        aioEspHomeApi = AioEspHomeApi.createWithAddress(
            espHomeDE.deviceMdnsName!.getOrCrash());
        //
        // aioEspHomeApi.listenToResponses();
        await aioEspHomeApi.helloRequestToEsp();
      } catch (mDnsCannotBeFound) {
        aioEspHomeApi = AioEspHomeApi.createWithAddress(
            espHomeDE.lastKnownIp!.getOrCrash());
        //
        // aioEspHomeApi.listenToResponses();
        await aioEspHomeApi.helloRequestToEsp();
      }
      await aioEspHomeApi.sendConnect('MyPassword');
      // await aioEspHomeApi.deviceInfoRequestToEsp();
      // await aioEspHomeApi.listEntitiesRequest();
      // await aioEspHomeApi.subscribeStatesRequest();
      await aioEspHomeApi.switchCommandRequest(
          int.parse(espHomeDE.espHomeSwitchKey!.getOrCrash()), false);
      await aioEspHomeApi.disconnect();
      return right(unit);
    } catch (exception) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnESPHome(ESPHomeDE espHomeDE) async {
    try {
      print('Turn on ESPHome device');
      AioEspHomeApi aioEspHomeApi;
      try {
        aioEspHomeApi = AioEspHomeApi.createWithAddress(
            espHomeDE.deviceMdnsName!.getOrCrash());
        //
        // aioEspHomeApi.listenToResponses();
        await aioEspHomeApi.helloRequestToEsp();
      } catch (mDnsCannotBeFound) {
        aioEspHomeApi = AioEspHomeApi.createWithAddress(
            espHomeDE.lastKnownIp!.getOrCrash());
        //
        // aioEspHomeApi.listenToResponses();
        await aioEspHomeApi.helloRequestToEsp();
      }
      await aioEspHomeApi.sendConnect('MyPassword');
      // await aioEspHomeApi.deviceInfoRequestToEsp();
      // await aioEspHomeApi.listEntitiesRequest();
      // await aioEspHomeApi.subscribeStatesRequest();
      await aioEspHomeApi.switchCommandRequest(
          int.parse(espHomeDE.espHomeSwitchKey!.getOrCrash()), true);
      await aioEspHomeApi.disconnect();
      return right(unit);
    } catch (exception) {
      return left(const CoreFailure.unexpected());
    }
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
  Future<Either<CoreFailure, Unit>> updateWithESPHome(
      {required ESPHomeDE espHome, String? forceUpdateLocation}) {
    // TODO: implement updateWithESPHome
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<ESPHomeDE?>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<ESPHomeDE?>>> watchBlinds() {
    // TODO: implement watchBlinds
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<ESPHomeDE?>>> watchBoilers() {
    // TODO: implement watchBoilers
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<ESPHomeDE?>>> watchLights() {
    // TODO: implement watchLights
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<ESPHomeDE?>>> watchUncompleted() {
    // TODO: implement watchUncompleted
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> create(ESPHomeDE espHome) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> manageHubRequestsForDevice(ESPHomeDE espHomeDE) async {
    final ESPHomeDE? device = espHomeDevices[espHomeDE.id!.getOrCrash()];
    if (device == null) {
      print('Cant change ESPHome, does not exist');
      return;
    }

    if (espHomeDE.getDeviceId() == device.getDeviceId()) {
      if (espHomeDE.deviceActions != device.deviceActions) {
        executeDeviceAction(espHomeDE);
      } else {
        print('No changes for ESPHome');
      }
      return;
    }
    print('manageHubRequestsForDevice in ESPHome');
  }

  @override
  Future<void> executeDeviceAction(ESPHomeDE espHomeDE) async {
    final DeviceActions? actionToPreform =
        EnumHelper.stringToDeviceAction(espHomeDE.deviceActions!.getOrCrash());

    espHomeDevices[espHomeDE.id!.getOrCrash()!] =
        espHomeDevices[espHomeDE.id!.getOrCrash()!]!
            .copyWith(deviceActions: espHomeDE.deviceActions);

    if (actionToPreform == DeviceActions.on) {
      turnOnESPHome(espHomeDE);
    } else if (actionToPreform == DeviceActions.off) {
      turnOffESPHome(espHomeDE);
    }
  }
}
