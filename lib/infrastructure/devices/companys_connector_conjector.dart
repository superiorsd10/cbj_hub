import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';

class CompanysConnectorConjector {
  static updateAllDevicesReposWithDeviceChanges(
      Stream<DeviceEntityAbstract> allDevices) {
    allDevices.listen((deviceEntityAbstract) {
      final String deviceVendor =
          deviceEntityAbstract.deviceVendor.getOrCrash();
      if (deviceVendor == VendorsAndServices.yeelight.toString()) {
        YeelightConnectorConjector()
            .manageHubRequestsForDevice(deviceEntityAbstract);
      } else if (deviceVendor == VendorsAndServices.tasmota.toString()) {
        TasmotaConnectorConjector()
            .manageHubRequestsForDevice(deviceEntityAbstract);
      } else {
        print('Cannot send device changes to its repo, company not supported');
      }
    });
  }

  static addAllDevicesToItsRepos(Map<String, DeviceEntityAbstract> allDevices) {
    for (final String deviceId in allDevices.keys) {
      final MapEntry<String, DeviceEntityAbstract> currentDeviceMapEntry =
          MapEntry<String, DeviceEntityAbstract>(
              deviceId, allDevices[deviceId]!);
      addDeviceToItsRepo(currentDeviceMapEntry);
    }
  }

  static addDeviceToItsRepo(
      MapEntry<String, DeviceEntityAbstract> deviceEntityAbstract) {
    final MapEntry<String, DeviceEntityAbstract> devicesEntry =
        MapEntry<String, DeviceEntityAbstract>(
            deviceEntityAbstract.key, deviceEntityAbstract.value);

    final String deviceVendor =
        deviceEntityAbstract.value.deviceVendor.getOrCrash();

    if (deviceVendor == VendorsAndServices.yeelight.toString()) {
      YeelightConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.tasmota.toString()) {
      TasmotaConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else {
      print('Cannot add device entity to its repo, type not supported');
    }
  }
}
