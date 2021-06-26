import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

abstract class IMqttServerRepository {
  /// Stream all subscription changes
  Stream<MqttPublishMessage> streamOfAllSubscriptions();

  Future<MqttServerClient> connect();

  /// Publish message to a specific topic
  void publishMessage(String topic, String message);

  /// Read mqtt last massage in given topic
  Future<String> readingFromMqtt(String topic);

  /// Subscribe to changes in given topic
  Stream<MqttPublishMessage>? subscribeToTopic(String topic);

  Future<int> exampleFromGit();
}
