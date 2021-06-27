import 'dart:async';

import 'package:cbj_hub/domain/internet_devices/i_internet_device_abstract.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/internet_devices/example_device/example_device_repository.dart';
import 'package:cbj_hub/injection.dart';

class Conector {
  static Future<void> startConector() async {
    List<IInternetDeviceRepository> internetDevices = [];

    internetDevices.add(ExampleDeviceRepository(
        id: 'Device id 1', name: 'Light1', topic: 'Light1'));
    internetDevices.add(ExampleDeviceRepository(
        id: 'Device id 2', name: 'Blind1', topic: 'Blind1'));
    internetDevices.add(ExampleDeviceRepository(
        id: 'Device id 3', name: 'Light2', topic: 'Light2'));

    // final s3 =
    //     StreamGroup.merge(internetDevices.map((e) => e.sendRequest()).toList());
    //
    // ConnectorStream.controller.addStream(s3);

    ConnectorStream.controller.stream.listen((event) async {
      await getIt<IMqttServerRepository>()
          .publishMessage(event.key, event.value);
    });
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class ConnectorStream {
  static StreamController<MapEntry<String, String>> controller =
      StreamController();

  Stream<MapEntry<String, String>> get stream =>
      controller.stream.asBroadcastStream();
}
