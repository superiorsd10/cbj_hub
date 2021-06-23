import 'package:cbj_hub/domain/server_for_cbj_app/i_server_for_cbj_app_repository.dart';
import 'package:cbj_hub/infrastructure/cbj_client/cbj_client.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IServerForCbjAppRepository)
class ServerForCbjAppRepository extends IServerForCbjAppRepository {
  @override
  void createStreamWithRemotePipes(String remotePipDNS) {
    SmartClient.createStreamWithRemotePipes('192.168.31.154');
  }
}
