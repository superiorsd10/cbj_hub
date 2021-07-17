import 'dart:async';

import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/injection.dart';

class Conector {
  static Future<void> startConector() async {
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
