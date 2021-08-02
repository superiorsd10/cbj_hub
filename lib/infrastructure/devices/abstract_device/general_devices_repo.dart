import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_entity.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_repository.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_repository.dart';

class GeneralDevicesRepo {
  static updateAllDevicesReposWithDeviceChanges(
      Stream<DeviceEntityAbstract> allDevices) {
    allDevices.listen((deviceEntityAbstract) {
      if (deviceEntityAbstract is ESPHomeDE) {
        ESPHomeRepo().manageHubRequestsForDevice(deviceEntityAbstract);
      }
      if (deviceEntityAbstract is YeelightDE) {
        YeelightRepo().manageHubRequestsForDevice(deviceEntityAbstract);
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
    if (deviceEntityAbstract.value is ESPHomeDE) {
      final MapEntry<String, ESPHomeDE> espHomeEntry =
          MapEntry<String, ESPHomeDE>(deviceEntityAbstract.key,
              deviceEntityAbstract.value as ESPHomeDE);
      ESPHomeRepo.espHomeDevices.addEntries([espHomeEntry]);
    } else if (deviceEntityAbstract.value is YeelightDE) {
      final MapEntry<String, YeelightDE> yeelightEntry =
          MapEntry<String, YeelightDE>(deviceEntityAbstract.key,
              deviceEntityAbstract.value as YeelightDE);
      YeelightRepo.yeelightDevices.addEntries([yeelightEntry]);
    } else {
      print('Cannot add device entity to its repo, type not supported');
    }
  }
}
