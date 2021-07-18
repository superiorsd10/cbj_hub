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

  static addAllDevicesToItsRepos(List<DeviceEntityAbstract> allDevices) {
    for (final DeviceEntityAbstract deviceEntityAbstract in allDevices) {
      addDeviceToItsRepo(deviceEntityAbstract);
    }
  }

  static addDeviceToItsRepo(DeviceEntityAbstract deviceEntityAbstract) {
    if (deviceEntityAbstract is SonoffS20DE) {
      SonoffS20Repo.sonoffDevices[deviceEntityAbstract.getDeviceId()] =
          deviceEntityAbstract;
    } else {
      print('Cannot add device entity to its repo, type not supported');
    }
  }
}
