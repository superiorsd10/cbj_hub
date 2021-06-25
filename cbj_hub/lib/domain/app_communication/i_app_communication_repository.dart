import 'package:mqtt_client/mqtt_client.dart';

abstract class IAppCommunicationRepository {
  Stream<MqttPublishMessage> getFromApp();

  void sendToApp(Stream<MqttPublishMessage> dataToSend);
}
