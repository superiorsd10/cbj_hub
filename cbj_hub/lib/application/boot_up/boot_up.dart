import 'package:cbj_hub/application/conector/conector.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/general_devices_repo.dart';
import 'package:cbj_hub/injection.dart';

class BootUp {
  BootUp() {
    setup();
  }

  static Future<void> setup() async {
    // Return all saved devices
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final List<DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    GeneralDevicesRepo.addAllDevicesToItsRepos(allDevices);

    getIt<IMqttServerRepository>();

    Conector.startConector();
  }
}
