abstract class IMqttServerRepository {
  void writingToMqtt(String message);
  String readingFromMqtt();
}
