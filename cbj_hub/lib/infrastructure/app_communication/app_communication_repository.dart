import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';

@LazySingleton(as: IAppCommunicationRepository)
class AppCommunicationRepository extends IAppCommunicationRepository {
  @override
  Stream<MqttPublishMessage> getFromApp() {
    // TODO: implement getFromApp
    throw UnimplementedError();
  }

  @override
  void sendToApp(Stream<MqttPublishMessage> dataToSend) {
    dataToSend.listen((MqttPublishMessage event) {
      print('Will send the topic "${event.payload.variableHeader?.topicName}" '
          'change with massage '
          '"${String.fromCharCodes(event.payload.message!)}" to the app ');
    });
  }
}
