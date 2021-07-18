import 'dart:async';

import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/i_sonoff_s20_repository.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_device_entity.dart';
import 'package:cbj_hub/infrastructure/aioesphomeapi/aioesphomeapi.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_s20/sonoff_s20_dtos.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbenum.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

class SonoffS20Repo implements ISonoffS20Repository {
  static Map<String, SonoffS20DE> sonoffDevices = {};

  @override
  Future<Either<CoreFailure, Unit>> delete(SonoffS20DE sonoffS20) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<SonoffS20DE?>>> getAllSonoffS20s() {
    // TODO: implement getAllSonoffS20s
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<SonoffS20Dtos?>>> getAllSonoffS20sAsDto() {
    // TODO: implement getAllSonoffS20sAsDto
    throw UnimplementedError();
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> moveDownBlinds(
      {required List<String>? sonoffS20sId, String? forceUpdateLocation}) {
    // TODO: implement moveDownBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> moveUpBlinds(
      {required List<String>? sonoffS20sId, String? forceUpdateLocation}) {
    // TODO: implement moveUpBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> stopBlinds(
      {required List<String>? sonoffS20sId, String? forceUpdateLocation}) {
    // TODO: implement stopBlinds
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffSonoffS20s(
      SonoffS20DE sonoffS20DE) async {
    try {
      print('Turn off sonoff device');
      AioEspHomeApi aioEspHomeApi;
      try {
        aioEspHomeApi = AioEspHomeApi.createWithAddress(
            sonoffS20DE.deviceMdnsName!.getOrCrash());
        //
        // aioEspHomeApi.listenToResponses();
        await aioEspHomeApi.helloRequestToEsp();
      } catch (mDnsCannotBeFound) {
        aioEspHomeApi = AioEspHomeApi.createWithAddress(
            sonoffS20DE.lastKnownIp!.getOrCrash());
        //
        // aioEspHomeApi.listenToResponses();
        await aioEspHomeApi.helloRequestToEsp();
      }
      await aioEspHomeApi.sendConnect('MyPassword');
      // await aioEspHomeApi.deviceInfoRequestToEsp();
      // await aioEspHomeApi.listEntitiesRequest();
      // await aioEspHomeApi.subscribeStatesRequest();
      await aioEspHomeApi.switchCommandRequest(
          int.parse(sonoffS20DE.sonoffS20SwitchKey!.getOrCrash()), false);
      await aioEspHomeApi.disconnect();
      return right(unit);
    } catch (exception) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnSonoffS20s(
      SonoffS20DE sonoffS20DE) async {
    try {
      print('Turn on sonoff device');
      AioEspHomeApi aioEspHomeApi;
      try {
        aioEspHomeApi = AioEspHomeApi.createWithAddress(
            sonoffS20DE.deviceMdnsName!.getOrCrash());
        //
        // aioEspHomeApi.listenToResponses();
        await aioEspHomeApi.helloRequestToEsp();
      } catch (mDnsCannotBeFound) {
        aioEspHomeApi = AioEspHomeApi.createWithAddress(
            sonoffS20DE.lastKnownIp!.getOrCrash());
        //
        // aioEspHomeApi.listenToResponses();
        await aioEspHomeApi.helloRequestToEsp();
      }
      await aioEspHomeApi.sendConnect('MyPassword');
      // await aioEspHomeApi.deviceInfoRequestToEsp();
      // await aioEspHomeApi.listEntitiesRequest();
      // await aioEspHomeApi.subscribeStatesRequest();
      await aioEspHomeApi.switchCommandRequest(
          int.parse(sonoffS20DE.sonoffS20SwitchKey!.getOrCrash()), true);
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
  Future<Either<CoreFailure, Unit>> updateWithSonoffS20(
      {required SonoffS20DE sonoffS20, String? forceUpdateLocation}) {
    // TODO: implement updateWithSonoffS20
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchBlinds() {
    // TODO: implement watchBlinds
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchBoilers() {
    // TODO: implement watchBoilers
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchLights() {
    // TODO: implement watchLights
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<SonoffS20DE?>>> watchUncompleted() {
    // TODO: implement watchUncompleted
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> create(SonoffS20DE sonoffS20) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> manageHubRequestsForDevice(SonoffS20DE sonoffS20DE) async {
    final SonoffS20DE? device = sonoffDevices[sonoffS20DE.id!.getOrCrash()];
    if (device == null) {
      print('Cant change SonoffS20, does not exist');
      return;
    }

    if (sonoffS20DE.getDeviceId() == device.getDeviceId()) {
      if (sonoffS20DE.deviceActions != device.deviceActions) {
        executeDeviceAction(sonoffS20DE);
      } else {
        print('Sonoff change is not supported');
      }
      return;
    }
    print('manageHubRequestsForDevice in sonoff');
  }

  @override
  Future<void> executeDeviceAction(SonoffS20DE sonoffS20DE) async {
    final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
        sonoffS20DE.deviceActions!.getOrCrash());

    sonoffDevices[sonoffS20DE.id!.getOrCrash()!] =
        sonoffDevices[sonoffS20DE.id!.getOrCrash()!]!
            .copyWith(deviceActions: sonoffS20DE.deviceActions);

    if (actionToPreform == DeviceActions.on) {
      turnOnSonoffS20s(sonoffS20DE);
    } else if (actionToPreform == DeviceActions.off) {
      turnOffSonoffS20s(sonoffS20DE);
    }
  }
}
