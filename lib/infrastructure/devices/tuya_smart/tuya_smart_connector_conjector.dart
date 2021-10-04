import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_jbt_a70_rgbcw_wf/tuya_smart_jbt_a70_rgbcw_wf_entity.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/cloudtuya.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/tuya_device_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_switch/tuya_smart_switch_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:multicast_dns/multicast_dns.dart';

@singleton
class TuyaSmartConnectorConjector implements AbstractCompanyConnectorConjector {
  TuyaSmartConnectorConjector() {}

  static late CloudTuya cloudTuya;

  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> _discoverNewDevices() async {
    // Not sure why but removing this line create errors
    await cloudTuya.findDevices();
    while (true) {
      try {
        final List<TuyaDeviceAbstract> deviceList =
            await cloudTuya.findDevices();

        for (final TuyaDeviceAbstract tuyaDevice in deviceList) {
          bool deviceExist = false;
          for (final DeviceEntityAbstract savedDevice
              in companyDevices.values) {
            if (savedDevice is TuyaSmartJbtA70RgbcwWfEntity) {
              if (tuyaDevice.id ==
                  savedDevice.tuyaSmartDeviceId!.getOrCrash()) {
                deviceExist = true;
                break;
              }
            } else {
              print('please add new tuya device type');
              break;
            }
          }
          if (!deviceExist) {
            final DeviceEntityAbstract addDevice =
                TuyaSmartHelpers.addDiscoverdDevice(tuyaDevice);
            CompanysConnectorConjector.addDiscoverdDeviceToHub(addDevice);
            final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
                MapEntry(addDevice.uniqueId.getOrCrash()!, addDevice);
            companyDevices.addEntries([deviceAsEntry]);

            CompanysConnectorConjector.addDiscoverdDeviceToHub(addDevice);
            print('New Tuya devices where add');
          }
        }
        await Future.delayed(const Duration(minutes: 3));
      } catch (e) {
        print('Error discover in Tuya $e');
        await Future.delayed(const Duration(minutes: 1));
      }
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract tuya_smart) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract tuya_smart) {
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
    DeviceEntityAbstract tuya_smartDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[tuya_smartDE.getDeviceId()];

    if (device is TuyaSmartJbtA70RgbcwWfEntity) {
      device.executeDeviceAction(tuya_smartDE);
    } else if (device is TuyaSmartSwitchEntity) {
      device.executeDeviceAction(tuya_smartDE);
    } else {
      print('TuyaSmart device type does not exist');
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
