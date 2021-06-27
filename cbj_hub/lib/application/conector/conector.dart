import 'dart:async';

import 'package:async/async.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/internet_devices/example_device/example_device_repository.dart';
import 'package:cbj_hub/injection.dart';

class Conector {
  static Future<void> startConector() async {
    var s1 = ExampleDeviceRepository(
            id: 'Device id 1', name: 'Light1', topic: 'Light1')
        .sendRequest();
    var s2 = ExampleDeviceRepository(
            id: 'Device id 2', name: 'Blind1', topic: 'Blind1')
        .sendRequest();
    var s3 = StreamGroup.merge([s1, s2]);

    ConnectorStream.controller.addStream(s3);

    ConnectorStream.controller.stream.listen((event) async {
      await getIt<IMqttServerRepository>()
          .publishMessage(event.key, event.value);
    });
  }
}

class ConnectorStream {
  static StreamController<MapEntry<String, String>> controller =
      StreamController();

  Stream<MapEntry<String, String>> get stream =>
      controller.stream.asBroadcastStream();
}
