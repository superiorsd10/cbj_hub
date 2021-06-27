import 'package:mqtt_client/mqtt_client.dart';

import '../i_internet_device_abstract.dart';

abstract class IExampleDeviceRepository extends IInternetDeviceRepository {
  IExampleDeviceRepository(
      {required String id, required String name, required String topic})
      : super(id, name, topic);

  /// Request of information from the hub
  Future<MqttPublishMessage> getRequest() async {
    return MqttPublishMessage();
  }

  /// Information that the device send to the hub
  Stream<MapEntry<String, String>> sendRequest() async* {}
}
