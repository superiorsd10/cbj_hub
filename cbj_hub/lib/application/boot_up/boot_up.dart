import 'package:cbj_hub/domain/server_for_cbj_app/i_server_for_cbj_app.dart';
import 'package:cbj_hub/injection.dart';

class BootUp {
  BootUp() {
    getIt<IServerForCbjAppRepository>()
        .createStreamWithRemotePipes('192.168.31.154');
  }
}
