import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:multicast_dns/multicast_dns.dart';

@singleton
class ESPHomeConnectorConjector implements AbstractCompanyConnectorConjector {
  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract espHome) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract espHome) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract espHomeDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[espHomeDE.getDeviceId()];

    if (device is ESPHomeLightEntity) {
      device.executeDeviceAction(espHomeDE);
    } else {
      logger.w('ESPHome device type does not exist');
    }

    logger.v('manageHubRequestsForDevice in ESPHome');
  }

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
        logger.v(
          'Dart observatory instance found at '
          '${srv.target}:${srv.port} for "$bundleId".',
        );
      }
    }
    return null;
  }
}
