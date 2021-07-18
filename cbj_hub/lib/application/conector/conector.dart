import 'dart:async';
import 'dart:convert';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/general_devices_repo.dart';
import 'package:cbj_hub/injection.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:typed_data/src/typed_buffer.dart';

class Conector {
  static Future<void> startConector() async {
    ConnectorStreamToMqtt.stream.listen((deviceEntityAbstract) async {
      await getIt<IMqttServerRepository>()
          .publishDeviceEntity(deviceEntityAbstract.value);
    });

    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    for (final String deviceId in allDevices.keys) {
      ConnectorStreamToMqtt.controller.sink.add(allDevices.entries.firstWhere(
          (MapEntry<String, DeviceEntityAbstract> a) => a.key == deviceId));
    }

    final IAppCommunicationRepository appCommunication =
        getIt<IAppCommunicationRepository>();

    getIt<IMqttServerRepository>().allHubDevicesSubscriptions();
    // appCommunication.sendToApp();

    GeneralDevicesRepo.updateAllDevicesReposWithDeviceChanges(
        ConnectorDevicesStreamFromMqtt().stream);
  }

  static Future<void> updateDevicesFromMqttDeviceChange(
      MapEntry<String, Map<String, dynamic>> deviceChangeFromMqtt) async {
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final Map<String, DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    final Map<String, dynamic> devicePropertyAndValues =
        deviceChangeFromMqtt.value;

    for (final DeviceEntityAbstract d in allDevices.values) {
      if (d.getDeviceId() == deviceChangeFromMqtt.key) {
        final Map<String, dynamic> deviceAsJson = d.toInfrastructure().toJson();

        for (final String propery in devicePropertyAndValues.keys) {
          final String pt = MqttPublishPayload.bytesToStringAsString(
                  (devicePropertyAndValues[propery] as MqttPublishMessage)
                      .payload
                      .message!)
              .replaceAll('\n', '');

          final Uint8Buffer? valueMessage =
              (devicePropertyAndValues[propery] as MqttPublishMessage)
                  .payload
                  .message;
          final String propertyValueString =
              String.fromCharCodes(valueMessage!);
          if (propertyValueString.contains('value')) {
            final Map<String, dynamic> propertyValueJson =
                jsonDecode(propertyValueString) as Map<String, dynamic>;
            deviceAsJson[propery] = propertyValueJson['value'];
          } else {
            deviceAsJson[propery] = propertyValueString;
          }
          final DeviceEntityAbstract savedDeviceWithSameIdAsMqtt =
              DeviceEntityDtoAbstract.fromJson(deviceAsJson).toDomain();

          ConnectorDevicesStreamFromMqtt.controller.sink
              .add(savedDeviceWithSameIdAsMqtt);
          return;
        }
      }
    }
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class ConnectorStreamToMqtt {
  static StreamController<MapEntry<String, DeviceEntityAbstract>> controller =
      StreamController();

  static Stream<MapEntry<String, DeviceEntityAbstract>> get stream =>
      controller.stream.asBroadcastStream();
}

/// Connect all streams from the mqtt devices changes into one stream that will
/// be sent to whoever need to be notify of changes
class ConnectorDevicesStreamFromMqtt {
  static StreamController<DeviceEntityAbstract> controller = StreamController();

  Stream<DeviceEntityAbstract> get stream =>
      controller.stream.asBroadcastStream();
}
