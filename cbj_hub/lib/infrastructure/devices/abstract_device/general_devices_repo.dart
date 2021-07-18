import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_s20/sonoff_s20_repository.dart';

class GeneralDevicesRepo {
  static updateAllDevicesReposWithDeviceChanges(
      Stream<DeviceEntityAbstract> allDevices) {
    allDevices.listen((deviceEntityAbstract) {
      if (deviceEntityAbstract is SonoffS20DE) {
        SonoffS20Repo().manageHubRequestsForDevice(deviceEntityAbstract);
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
    if (deviceEntityAbstract.value is SonoffS20DE) {
      final MapEntry<String, SonoffS20DE> sonoffEntry =
          MapEntry<String, SonoffS20DE>(deviceEntityAbstract.key,
              deviceEntityAbstract.value as SonoffS20DE);
      SonoffS20Repo.sonoffDevices.addEntries([sonoffEntry]);
    } else {
      print('Cannot add device entity to its repo, type not supported');
    }
  }
}
