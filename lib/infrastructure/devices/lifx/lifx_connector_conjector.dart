import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_white/lifx_white_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:lifx_http_api/lifx_http_api.dart' as lifx;
import 'package:multicast_dns/multicast_dns.dart';

@singleton
class LifxConnectorConjector implements AbstractCompanyConnectorConjector {
  Future<String> accountLogin(GenericLifxLoginDE genericLifxLoginDE) async {
    lifxClient = lifx.Client(genericLifxLoginDE.lifxApiKey.getOrCrash());
    _discoverNewDevices();
    return 'Success';
  }

  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  static lifx.Client? lifxClient;

  Future<void> _discoverNewDevices() async {
    while (true) {
      try {
        final Iterable<lifx.Bulb> lights = await lifxClient!.listLights();

        for (final lifx.Bulb lifxDevice in lights) {
          bool deviceExist = false;
          for (DeviceEntityAbstract savedDevice in companyDevices.values) {
            savedDevice = savedDevice as LifxWhiteEntity;

            if (lifxDevice.id == savedDevice.lifxDeviceId!.getOrCrash()) {
              deviceExist = true;
              break;
            }
          }
          if (!deviceExist) {
            final DeviceEntityAbstract addDevice =
                LifxHelpers.addDiscoverdDevice(lifxDevice);
            CompanysConnectorConjector.addDiscoverdDeviceToHub(addDevice);
            final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
                MapEntry(addDevice.uniqueId.getOrCrash()!, addDevice);
            companyDevices.addEntries([deviceAsEntry]);

            CompanysConnectorConjector.addDiscoverdDeviceToHub(addDevice);
            print('New Lifx devices where add');
          }
        }
        await Future.delayed(const Duration(minutes: 3));
      } catch (e) {
        print('Error discover in Lifx $e');
        await Future.delayed(const Duration(minutes: 1));
      }
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract lifx) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract lifx) {
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
    DeviceEntityAbstract lifxDE,
  ) async {
    final DeviceEntityAbstract? device = companyDevices[lifxDE.getDeviceId()];

    if (device is LifxWhiteEntity) {
      device.executeDeviceAction(lifxDE);
    } else {
      print('Lifx device type does not exist');
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  }) async {
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
        ResourceRecordQuery.service(ptr.domainName),
      )) {
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
