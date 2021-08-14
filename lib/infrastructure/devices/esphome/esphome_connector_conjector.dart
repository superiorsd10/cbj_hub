import 'dart:async';

import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_device_actions.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbenum.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:multicast_dns/multicast_dns.dart';

@singleton
class ESPHomeConnectorConjector implements AbstractCompanyConnectorConjector {
  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  @override
  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract espHome) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract espHome) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> executeDeviceAction(DeviceEntityAbstract espHomeDE) async {
    if (espHomeDE is GenericLightDE) {
      final GenericLightDE espHomeDELight = espHomeDE;
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          espHomeDELight.lightSwitchState!.getOrCrash());

      companyDevices[espHomeDELight.uniqueId.getOrCrash()!] =
          (companyDevices[espHomeDELight.uniqueId.getOrCrash()!]!
              as GenericLightDE)
            ..lightSwitchState =
                GenericLightSwitchState(actionToPreform.toString());

      if (actionToPreform == DeviceActions.on) {
        (await turnOnESPHome(espHomeDELight)).fold(
            (l) => print('Error turning light on'),
            (r) => print('Light turn on success'));
      } else if (actionToPreform == DeviceActions.off) {
        (await turnOffESPHome(espHomeDELight)).fold(
            (l) => print('Error turning light off'),
            (r) => print('Light turn off success'));
      }
    }
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<void> manageHubRequestsForDevice(
      DeviceEntityAbstract espHomeDE) async {
    final GenericLightDE? device =
        companyDevices[espHomeDE.getDeviceId()] as GenericLightDE;
    if (device == null) {
      print('Cant change ESPHome, does not exist');
      return;
    }

    if (espHomeDE.getDeviceId() == device.getDeviceId()) {
      if ((espHomeDE as GenericLightDE).lightSwitchState !=
          device.lightSwitchState) {
        executeDeviceAction(espHomeDE);
      } else {
        print('No changes for ESPHome');
      }
      return;
    }
    print('manageHubRequestsForDevice in ESPHome');
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffESPHome(
      GenericLightDE espHomeDE) async {
    print('Turn Off ESPHome');

    if (companyDevices[espHomeDE.uniqueId.getOrCrash()] is ESPHomeLightEntity) {
      return ESPHomeDeviceActions.turnOff(
          companyDevices[espHomeDE.uniqueId.getOrCrash()]
              as ESPHomeLightEntity);
    }
    return left(const CoreFailure.unexpected());
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnESPHome(
      GenericLightDE espHomeDE) async {
    print('Turn On ESPHome');

    if (companyDevices[espHomeDE.uniqueId.getOrCrash()] is ESPHomeLightEntity) {
      return ESPHomeDeviceActions.turnOn(
          companyDevices[espHomeDE.uniqueId.getOrCrash()]!
              as ESPHomeLightEntity);
    }
    return left(const CoreFailure.unexpected());
  }

  @override
  Future<Either<CoreFailure, Unit>> updateDatabase(
      {required String pathOfField,
      required Map<String, dynamic> fieldsToUpdate,
      String? forceUpdateLocation}) async {
    // TODO: implement updateDatabase
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
