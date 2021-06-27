/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 31/05/2017
 * Copyright :  S.Hamblett
 */

import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

@LazySingleton(as: IMqttServerRepository)
class MqttServerRepository extends IMqttServerRepository {
  MqttServerRepository() {
    connect();
  }

  /// Static instance of connection to mqtt broker
  static MqttServerClient client = MqttServerClient('127.0.0.1', 'CBJ_Hub');

  /// Connect the client to mqtt if not in connecting or connected state already
  @override
  Future<MqttServerClient> connect() async {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      return client;
    } else if (client.connectionStatus!.state ==
        MqttConnectionState.connecting) {
      await Future.delayed(const Duration(seconds: 1));
      return client;
    } else {
      client.disconnect();
    }

    client.logging(on: false);

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    print('Client connecting');
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Error: $e');
      client.disconnect();
    }
    return client;
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await connect();
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  @override
  Stream<MqttPublishMessage> streamOfAllSubscriptions() async* {
    yield* client.published!;
  }

  @override
  Future<void> publishMessage(String topic, String message) async {
    await connect();
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  @override
  Future<String> readingFromMqtt(String topic) {
    // TODO: implement readingFromMqtt
    throw UnimplementedError();
  }

  /// Callback function for connection succeeded
  void onConnected() {
    print('Connected');
  }

  /// Unconnected
  void onDisconnected() {
    print('Disconnected');
  }

  /// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  /// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  /// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  /// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }
}
