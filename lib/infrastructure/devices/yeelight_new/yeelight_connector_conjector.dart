import 'dart:async';

import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight_new/yeelight_1se/yeelight_1se_device_actions.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight_new/yeelight_1se/yeelight_1se_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbenum.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:multicast_dns/multicast_dns.dart';

@singleton
class YeelightConnectorConjector implements AbstractCompanyConnectorConjector {
  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  @override
  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract yeelight) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract yeelight) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> executeDeviceAction(DeviceEntityAbstract yeelightDE) async {
    if (yeelightDE is GenericLightDE) {
      final GenericLightDE yeelightDELight = yeelightDE;
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          yeelightDELight.deviceActions!.getOrCrash());
      //
      // companyDevices[yeelightDELight.id!.getOrCrash()!] =
      //     companyDevices[yeelightDELight.id!.getOrCrash()!]!
      //         .copyWith(deviceActions: yeelightDELight.deviceActions);

      if (actionToPreform == DeviceActions.on) {
        turnOnYeelight(yeelightDELight);
      } else if (actionToPreform == DeviceActions.off) {
        turnOffYeelight(yeelightDELight);
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
      DeviceEntityAbstract yeelightDE) async {
    final GenericLightDE? device =
        companyDevices[yeelightDE.getDeviceId()] as GenericLightDE;
    if (device == null) {
      print('Cant change Yeelight, does not exist');
      return;
    }

    if (yeelightDE.getDeviceId() == device.getDeviceId()) {
      if ((yeelightDE as GenericLightDE).deviceActions !=
          device.deviceActions) {
        executeDeviceAction(yeelightDE);
      } else {
        print('No changes for Yeelight');
      }
      return;
    }
    print('manageHubRequestsForDevice in Yeelight');
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffYeelight(
      GenericLightDE yeelightDE) async {
    print('Turn Off Yeelight');

    if (companyDevices[yeelightDE.uniqueId.getOrCrash()] is Yeelight1SeEntity) {
      return Yeelight1SeDeviceActions.turnOff(
          companyDevices[yeelightDE.uniqueId.getOrCrash()]
              as Yeelight1SeEntity);
    }
    return left(const CoreFailure.unexpected());
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnYeelight(
      GenericLightDE yeelightDE) async {
    print('Turn On Yeelight');

    if (companyDevices[yeelightDE.uniqueId.getOrCrash()] is Yeelight1SeEntity) {
      return Yeelight1SeDeviceActions.turnOn(
          companyDevices[yeelightDE.uniqueId.getOrCrash()]
              as Yeelight1SeEntity);
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
