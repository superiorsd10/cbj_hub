import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_entity.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_repository.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight_new/yeelight_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';

class CompanysConnectorConjector {
  static updateAllDevicesReposWithDeviceChanges(
      Stream<DeviceEntityAbstract> allDevices) {
    allDevices.listen((deviceEntityAbstract) {
      if (deviceEntityAbstract is GenericLightDE) {
        YeelightConnectorConjector()
            .manageHubRequestsForDevice(deviceEntityAbstract);
      } else if (deviceEntityAbstract is ESPHomeDE) {
        ESPHomeRepo().manageHubRequestsForDevice(deviceEntityAbstract);
      } else {
        print('Cannot send device changes to its repo, type not supported');
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
    if (deviceEntityAbstract.value is GenericLightDE) {
      final MapEntry<String, GenericLightDE> genericLightEntry =
          MapEntry<String, GenericLightDE>(deviceEntityAbstract.key,
              deviceEntityAbstract.value as GenericLightDE);
      YeelightConnectorConjector.companyDevices.addEntries([genericLightEntry]);
    } else if (deviceEntityAbstract.value is ESPHomeDE) {
      final MapEntry<String, ESPHomeDE> espHomeEntry =
          MapEntry<String, ESPHomeDE>(deviceEntityAbstract.key,
              deviceEntityAbstract.value as ESPHomeDE);
      ESPHomeRepo.espHomeDevices.addEntries([espHomeEntry]);
    } else if (deviceEntityAbstract.value.deviceVendor!.getOrCrash() ==
        VendorsAndServices.yeelight.toString()) {
      final MapEntry<String, DeviceEntityAbstract> yeelightEntry =
          MapEntry<String, DeviceEntityAbstract>(
              deviceEntityAbstract.key, deviceEntityAbstract.value);
      YeelightConnectorConjector.companyDevices.addEntries([yeelightEntry]);
    } else {
      print('Cannot add device entity to its repo, type not supported');
    }
  }
}
