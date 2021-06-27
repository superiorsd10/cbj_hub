import 'package:mqtt_client/mqtt_client.dart';

abstract class IExampleDeviceRepository {
  /// Request of information from the hub
  Future<MqttPublishMessage> getRequest();

  /// Information that the device send to the hub
  Stream<MapEntry<String, String>> sendRequest();
}
