import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/injection.dart';

class BootUp {
  BootUp() {
    // getIt<IServerForCbjAppRepository>()
    //     .createStreamWithRemotePipes('192.168.31.154');

    getIt<IMqttServerRepository>().writingToMqtt('Hello Guy');
  }
}
