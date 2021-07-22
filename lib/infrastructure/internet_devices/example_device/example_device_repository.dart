import 'dart:async';

import 'package:cbj_hub/domain/internet_devices/example_device/i_example_device_repository.dart';
import 'package:mqtt_client/mqtt_client.dart';

class ExampleDeviceRepository extends IExampleDeviceRepository {
  ExampleDeviceRepository(
      {required String id, required String name, required String topic})
      : super(id: id, name: name, topic: topic);

  @override
  Future<MqttPublishMessage> getRequest() async {
    print('');
    return MqttPublishMessage();
  }

  @override
  Stream<MapEntry<String, String>> sendRequest() async* {
    final NumberCreator numberCreator = NumberCreator();
    yield* numberCreator.stream.map((event) =>
        MapEntry(topic, 'Turn Instance of $name to ${event.toString()}'));
  }
}

class NumberCreator {
  NumberCreator() {
    Timer.periodic(const Duration(seconds: 1), (t) {
      _controller.sink.add(t.tick.toString());
    });
  }

  final _controller = StreamController<String>();

  Stream<String> get stream => _controller.stream;
}
