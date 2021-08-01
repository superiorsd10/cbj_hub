import 'dart:async';
import 'dart:io';

import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_entity.dart';
import 'package:cbj_hub/domain/devices/yeelight/i_yeelight_device_repository.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_dtos.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:yeedart/yeedart.dart';

class YeelightRepo implements IYeelightRepository {
  static Map<String, ESPHomeDE> espHomeDevices = {};

  @override
  Future<Either<CoreFailure, Unit>> create(YeelightDE yeelight) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(YeelightDE yeelight) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> executeDeviceAction(YeelightDE yeelightDE) {
    // TODO: implement executeDeviceAction
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<YeelightDE?>>> getAllYeelight() {
    // TODO: implement getAllYeelight
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, KtList<YeelightDtos?>>> getAllYeelightAsDto() {
    // TODO: implement getAllYeelightAsDto
    throw UnimplementedError();
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<void> manageHubRequestsForDevice(YeelightDE yeelightDE) {
    // TODO: implement manageHubRequestsForDevice
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffYeelight(
      YeelightDE yeelightDE) async {
    try {
      try {
        final device = Device(
            address: InternetAddress(yeelightDE.lastKnownIp!.getOrCrash()),
            port: int.parse(yeelightDE.yeelightPort!.getOrCrash()));

        await device.turnOff();
        device.disconnect();

        return right(unit);
      } catch (e) {
        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull((element) =>
            element.id.toString() == yeelightDE.yeelightDeviceId!.getOrCrash());
        if (response == null) {
          return left(const CoreFailure.unexpected());
        }

        final device = Device(address: response.address, port: response.port!);

        await device.turnOff();
        device.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnYeelight(
      YeelightDE yeelightDE) async {
    try {
      try {
        final device = Device(
            address: InternetAddress(yeelightDE.lastKnownIp!.getOrCrash()),
            port: int.parse(yeelightDE.yeelightPort!.getOrCrash()));

        await device.turnOn();
        device.disconnect();

        return right(unit);
      } catch (e) {
        final responses = await Yeelight.discover();

        final response = responses.firstWhereOrNull((element) =>
            element.id.toString() == yeelightDE.yeelightDeviceId!.getOrCrash());
        if (response == null) {
          return left(const CoreFailure.unexpected());
        }

        final device = Device(address: response.address, port: response.port!);

        await device.turnOn();
        device.disconnect();

        return right(unit);
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> updateDatabase(
      {required String pathOfField,
      required Map<String, dynamic> fieldsToUpdate,
      String? forceUpdateLocation}) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> updateWithYeelight(
      {required YeelightDE yeelight, String? forceUpdateLocation}) {
    // TODO: implement updateWithYeelight
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<YeelightDE?>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<YeelightDE?>>> watchLights() {
    // TODO: implement watchLights
    throw UnimplementedError();
  }

  @override
  Stream<Either<CoreFailure, KtList<YeelightDE?>>> watchUncompleted() {
    // TODO: implement watchUncompleted
    throw UnimplementedError();
  }

  Future<String?> getIpFromMDNS(String deviceMdnsName) async {
    final String name = '$deviceMdnsName.local';
    final MDnsClient client = MDnsClient();
    // Start the client with default options.
    await client.start();

    // Get the PTR record for the service.
    await for (final PtrResourceRecord ptr in client
        .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
      // Use the domainName from the PTR record to get the SRV record,
      // which will have the port and local hostname.
      // Note that duplicate messages may come through, especially if any
      // other mDNS queries are running elsewhere on the machine.
      await for (final SrvResourceRecord srv
          in client.lookup<SrvResourceRecord>(
              ResourceRecordQuery.service(ptr.domainName))) {
        // Domain name will be something like "io.flutter.example@some-iphone.local._dartobservatory._tcp.local"
        final String bundleId =
            ptr.domainName; //.substring(0, ptr.domainName.indexOf('@'));
        print('Dart observatory instance found at '
            '${srv.target}:${srv.port} for "$bundleId".');
      }
    }
    return null;
  }
}
