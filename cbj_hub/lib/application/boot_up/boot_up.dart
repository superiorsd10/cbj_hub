import 'package:cbj_hub/infrastructure/mqtt_server/mqtt_server_repository.dart';

class BootUp {
  BootUp() {
    setup();
  }

  static Future<void> setup() async {
    final MqttServerRepository mqttServerRepository =
        MqttServerRepository.clientName('LightClient');
    await mqttServerRepository.connect();
    mqttServerRepository.subscribeToTopic('Light');
    mqttServerRepository.publishMessage('Light', 'Turn Light on');
  }
}
