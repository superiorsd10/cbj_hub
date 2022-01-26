import 'dart:async';
import 'dart:io';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:multicast_dns/multicast_dns.dart';

@singleton
class ESPHomeConnectorConjector implements AbstractCompanyConnectorConjector {
  ESPHomeConnectorConjector() {
    _discoverNewDevices();
  }

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> _discoverNewDevices() async {
    const String name = '_esphomelib._tcp';

    while (true) {
      final MDnsClient client = MDnsClient();

      await client.start();

      await for (final PtrResourceRecord ptr in client
          .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
        await for (final SrvResourceRecord srv
            in client.lookup<SrvResourceRecord>(
          ResourceRecordQuery.service(ptr.domainName),
        )) {
          final String bundleId = ptr.domainName;
          final String deviceMdnsName =
              bundleId.substring(0, bundleId.indexOf('.'));
          addNewDeviceByMdnsName(deviceMdnsName, port: srv.port.toString());
        }
      }
      client.stop();

      await Future.delayed(const Duration(minutes: 3));
    }
  }

  /// Add new devices to [companyDevices] if not exist
  Future<void> addNewDeviceByMdnsName(String mDnsName, {String? port}) async {
    for (final DeviceEntityAbstract device in companyDevices.values) {
      if (device is ESPHomeLightEntity) {
        if (mDnsName == device.deviceMdnsName.getOrCrash()) {
          return;
        }
      } else {
        logger.w("Can't add espHome device, type was not set to get device ID");
      }
    }

    final List<DeviceEntityAbstract> espDevice =
        await EspHomeHelpers.addDiscoverdDevice(mDnsName: mDnsName, port: port);

    if (espDevice.isEmpty) {
      return;
    }

    for (final DeviceEntityAbstract entityAsDevice in espDevice) {
      final DeviceEntityAbstract deviceToAdd =
          CompanysConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
    }
    logger.v('New espHome devices name:$mDnsName');
  }

  /// Gets mDNS name and return the IP of that device
  static Future<String?> getIpFromMDNS(String deviceMdnsName) async {
    String validDeviceMdnsName = deviceMdnsName;
    if (!validDeviceMdnsName.contains('.local')) {
      validDeviceMdnsName += '.local';
    }
    try {
      final List<InternetAddress> deviceIpList =
          await InternetAddress.lookup(validDeviceMdnsName);
      if (deviceIpList.isNotEmpty) {
        return deviceIpList[0].address;
      }
    } catch (e) {
      logger.e(
        'Crash when searching the IP for device with mDNS\n$e',
      );
    }

    return null;
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract espHomeDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[espHomeDE.getDeviceId()];

    if (device is ESPHomeLightEntity) {
      device.executeDeviceAction(newEntity: espHomeDE);
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
}
