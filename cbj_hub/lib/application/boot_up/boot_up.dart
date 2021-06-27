import 'package:cbj_hub/application/conector/conector.dart';
import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/injection.dart';

class BootUp {
  BootUp() {
    setup();
  }

  static Future<void> setup() async {
    getIt<IMqttServerRepository>();

    getIt<IMqttServerRepository>().streamOfAllSubscriptions().listen((event) {
      print('Got event');
    });

    final IAppCommunicationRepository appCommunication =
        getIt<IAppCommunicationRepository>();
    appCommunication
        .sendToApp(getIt<IMqttServerRepository>().streamOfAllSubscriptions());

    Conector.startConector();
  }
}
