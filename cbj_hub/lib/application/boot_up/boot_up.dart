import 'package:cbj_hub/application/conector/conector.dart';
import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/injection.dart';
import 'package:mqtt_client/mqtt_client.dart';

class BootUp {
  BootUp() {
    setup();
    Conector.startConector();
  }

  Future<void> setup() async {
    getIt<IMqttServerRepository>().readingFromMqtt('StairsLights');

    final Stream<MqttPublishMessage> subscriptionStream =
        getIt<IMqttServerRepository>().streamOfAllSubscriptions();

    getIt<IAppCommunicationRepository>().sendToApp(subscriptionStream);
  }
}
