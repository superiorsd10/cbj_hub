import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/injection.dart';

class BootUp {
  BootUp() {
    setup();
  }

  static Future<void> setup() async {
    // Return all saved devices
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    CompanysConnectorConjector.addAllDevicesToItsRepos(allDevices);

    getIt<IMqttServerRepository>();

    Connector.startConnector();
  }
}
