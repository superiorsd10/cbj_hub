import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:mqtt_client/mqtt_client.dart';

abstract class IAppCommunicationRepository {
  Stream<DeviceEntity> getFromApp(Stream<ClientStatusRequests> request);

  void sendToApp(Stream<MqttPublishMessage> dataToSend);
}
