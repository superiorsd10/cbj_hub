import 'dart:async';

import 'package:async/async.dart';
import 'package:cbj_hub/domain/example_device/i_example_device_repository.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/injection.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Conector {
  static Future<void> startConector() async {
    var s1 = getIt<IExampleDeviceRepository>().sendRequest();
    var s2 = getIt<IExampleDeviceRepository>().sendRequest();
    var s3 = StreamGroup.merge([s1, s2]);

    ConnectorStream.controller.addStream(s3);

    ConnectorStream.controller.stream.listen((event) {
      final MqttClientPayloadBuilder mqttClientPayloadBuilder =
          MqttClientPayloadBuilder();
      mqttClientPayloadBuilder
          .addString('Hello old from mqtt_client number $event');

      // 'ExampleDevice', 'Hello Guy'
      getIt<IMqttServerRepository>().publishMessage('Light', 'Turn light on');
      print('Stream listen $event');
    });
  }
}

class ConnectorStream {
  static StreamController<String> controller = StreamController();

  Stream<String> get stream => controller.stream.asBroadcastStream();
}
