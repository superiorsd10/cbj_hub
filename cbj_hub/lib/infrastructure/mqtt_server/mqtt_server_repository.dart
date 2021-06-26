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
  final MqttServerClient client;

  MqttServerRepository(this.client);

  factory MqttServerRepository.clientName(String clientName) {
    return MqttServerRepository(MqttServerClient('127.0.0.1', clientName));
  }

  @override
  Future<MqttServerClient> connect() async {
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

    print('EMQ X Cloud client connecting');
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
  Stream<MqttPublishMessage>? subscribeToTopic(String topic) async* {
    client.subscribe(topic, MqttQos.atMostOnce);

    client.published!.listen((MqttPublishMessage message) {
      print(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });

    yield* client.published!;
  }

  @override
  Stream<MqttPublishMessage> streamOfAllSubscriptions() async* {
    // yield* client.published!;
  }

  @override
  void publishMessage(String topic, String message) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    print('Publish $topic: $message');
    print('EXAMPLE::Sleeping....');
  }

  @override
  Future<int> exampleFromGit() {
    // TODO: implement exampleFromGit
    throw UnimplementedError();
  }

  @override
  Future<String> readingFromMqtt(String topic) {
    // TODO: implement readingFromMqtt
    throw UnimplementedError();
  }

// Callback function
// connection succeeded
  void onConnected() {
    print('Connected');
  }

// unconnected
  void onDisconnected() {
    print('Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }
}
