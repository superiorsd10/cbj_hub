import 'dart:async';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/injection.dart';

class Conector {
  static Future<void> startConector() async {
    ConnectorStreamToMqtt.controller.stream
        .listen((deviceEntityAbstract) async {
      await getIt<IMqttServerRepository>()
          .publishDeviceEntity(deviceEntityAbstract);
    });

    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final List<DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    for (final DeviceEntityAbstract device in allDevices) {
      ConnectorStreamToMqtt.controller.sink.add(device);
    }

    final IAppCommunicationRepository appCommunication =
        getIt<IAppCommunicationRepository>();

    getIt<IMqttServerRepository>().allHubDevicesSubscriptions();
    // appCommunication.sendToApp();

    ConnectorDevicesStreamFromMqtt().stream.listen((event) async {
      print('Convert to device and save it to all devices');
    });
  }

  Future<void> updateDevicesFromMqttDeviceChange(
      MapEntry<String, Map<String, dynamic>> deviceChangeFromMqtt) async {
    final ISavedDevicesRepo savedDevicesRepo = getIt<ISavedDevicesRepo>();

    final List<DeviceEntityAbstract> allDevices =
        await savedDevicesRepo.getAllDevices();

    DeviceEntityAbstract savedDeviceWithSameIdAsMqtt;
    for (final DeviceEntityAbstract d in allDevices) {
      if (d.getDeviceId() == deviceChangeFromMqtt.key) {
        print('This is the device $d');
      }
    }
  }
}

/// Connect all streams from the internet devices into one stream that will be
/// send to mqtt broker to update devices states
class ConnectorStreamToMqtt {
  static StreamController<DeviceEntityAbstract> controller = StreamController();

  Stream<DeviceEntityAbstract> get stream =>
      controller.stream.asBroadcastStream();
}

/// Connect all streams from the mqtt devices changes into one stream that will
/// be sent to whoever need to be notify of changes
class ConnectorDevicesStreamFromMqtt {
  static StreamController<MapEntry<String, Map<String, dynamic>>> controller =
      StreamController();

  Stream<MapEntry<String, dynamic>> get stream =>
      controller.stream.asBroadcastStream();
}
