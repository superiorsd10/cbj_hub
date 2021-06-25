import 'package:mqtt_client/mqtt_client.dart';

abstract class IMqttServerRepository {
  /// Stream all subscription changes
  Stream<MqttPublishMessage> streamOfAllSubscriptions();

  /// Publish message to a specific topic
  void publishMessage(MqttClientPayloadBuilder mqttPublishMessage);

  /// Read mqtt last massage in given topic
  Future<String> readingFromMqtt(String topic);

  /// Subscribe to changes in given topic
  Stream<MqttClientPayloadBuilder> subscribeToTopic(String topic);
}
