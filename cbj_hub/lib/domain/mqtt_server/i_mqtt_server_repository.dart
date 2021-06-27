import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

abstract class IMqttServerRepository {
  ///Connecting the hub client to broker
  Future<MqttServerClient> connect();

  /// Stream all subscription changes
  Stream<MqttPublishMessage> streamOfAllSubscriptions();

  /// Publish message to a specific topic
  Future<void> publishMessage(String topic, String message);

  /// Read mqtt last massage in given topic
  Future<String> readingFromMqtt(String topic);

  /// Subscribe to changes in given topic
  Future<void> subscribeToTopic(String topic);
}
