import 'package:cbj_hub/application/conector/conector.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/injection.dart';

class BootUp {
  BootUp() {
    setup();
  }

  static Future<void> setup() async {
    await getIt<IMqttServerRepository>().connect();

    Conector.startConector();
  }
}
