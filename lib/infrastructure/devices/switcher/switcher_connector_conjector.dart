import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_discover.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_runner/switcher_runner_entity.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_v2/switcher_v2_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:multicast_dns/multicast_dns.dart';

@singleton
class SwitcherConnectorConjector implements AbstractCompanyConnectorConjector {
  SwitcherConnectorConjector() {
    _discoverNewDevices();
  }

  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> _discoverNewDevices() async {
    SwitcherDiscover.discover20002Devices().listen((switcherApiObject) {
      addOnlyNewSwitcherDevice(switcherApiObject);
    });
    SwitcherDiscover.discover20003Devices().listen((switcherApiObject) {
      addOnlyNewSwitcherDevice(switcherApiObject);
    });
  }

  Future<void> addOnlyNewSwitcherDevice(
      SwitcherApiObject switcherApiObject) async {
    for (final DeviceEntityAbstract savedDevice in companyDevices.values) {
      if (savedDevice is SwitcherV2Entity) {
        if (switcherApiObject.deviceId ==
            savedDevice.switcherDeviceId.getOrCrash()) {
          return;
        }
      } else if (savedDevice is SwitcherRunnerEntity) {
        if (switcherApiObject.deviceId ==
            savedDevice.switcherDeviceId.getOrCrash()) {
          return;
        }
      } else {
        print("Can't add switcher device, type was not set to get device ID");
      }
    }

    final DeviceEntityAbstract? addDevice =
        SwitcherHelpers.addDiscoverdDevice(switcherApiObject);
    if (addDevice == null) {
      return;
    }
    CompanysConnectorConjector.addDiscoverdDeviceToHub(addDevice);
    final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
        MapEntry(addDevice.uniqueId.getOrCrash()!, addDevice);
    companyDevices.addEntries([deviceAsEntry]);

    CompanysConnectorConjector.addDiscoverdDeviceToHub(addDevice);
    print('New switcher devices name:${switcherApiObject.switcherName}');
  }

  @override
  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract switcher) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract switcher) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<void> manageHubRequestsForDevice(
      DeviceEntityAbstract switcherDE) async {
    final DeviceEntityAbstract? device =
        companyDevices[switcherDE.getDeviceId()];

    if (device is SwitcherV2Entity) {
      device.executeDeviceAction(switcherDE);
    } else if (device is SwitcherRunnerEntity) {
      device.executeDeviceAction(switcherDE);
    } else {
      print('Switcher device type does not exist');
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
        print(
          'Dart observatory instance found at '
          '${srv.target}:${srv.port} for "$bundleId".',
        );
      }
    }
    return null;
  }
}
