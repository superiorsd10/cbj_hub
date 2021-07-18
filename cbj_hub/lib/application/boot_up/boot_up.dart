import 'package:cbj_hub/application/conector/conector.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/injection.dart';

class BootUp {
  BootUp() {
    setup();
  }

  static Future<void> setup() async {
    // Return all saved devices
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    await savedDevicesRepo.getAllDevices();

    getIt<IMqttServerRepository>();

    Conector.startConector();
  }
}
