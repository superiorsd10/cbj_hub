import 'dart:async';

import 'package:cbj_hub/domain/example_device/i_example_device_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';

@LazySingleton(as: IExampleDeviceRepository)
class ExampleDeviceRepository extends IExampleDeviceRepository {
  @override
  Future<MqttPublishMessage> getRequest() async {
    print('');
    return MqttPublishMessage();
  }

  @override
  Stream<MapEntry<String, String>> sendRequest() async* {
    final NumberCreator numberCreator = NumberCreator();
    yield* numberCreator.stream;
  }
}

class NumberCreator {
  NumberCreator() {
    Timer.periodic(const Duration(seconds: 1), (t) {
      MapEntry<String, String> b =
          MapEntry('LightA', 'Turn lights on ${t.tick}');
      _controller.sink.add(b);
    });
  }

  final _controller = StreamController<MapEntry<String, String>>();

  Stream<MapEntry<String, String>> get stream => _controller.stream;
}
