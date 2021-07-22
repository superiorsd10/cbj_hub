abstract class IMqttClientRepository {
  void writingToMqtt(String message);
  String readingFromMqtt();
}
