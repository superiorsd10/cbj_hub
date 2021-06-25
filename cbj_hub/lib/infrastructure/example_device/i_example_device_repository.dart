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
  Stream<String> sendRequest() async* {
    final NumberCreator numberCreator = NumberCreator();
    yield* numberCreator.stream.map((int event) => event.toString());
  }
}

class NumberCreator {
  NumberCreator() {
    Timer.periodic(const Duration(seconds: 1), (t) {
      _controller.sink.add(_count);
      _count++;
    });
  }

  var _count = 1;

  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;
}
