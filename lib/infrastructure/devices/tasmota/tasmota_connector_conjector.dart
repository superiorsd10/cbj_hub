import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_led/tasmota_led_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';

@singleton
class TasmotaConnectorConjector implements AbstractCompanyConnectorConjector {
  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  TasmotaConnectorConjector() {
    discoverNewDevices();
  }

  Future<void> discoverNewDevices() async {
    /// Make all tasmota devices repost themselves under discovery
    getIt<IMqttServerRepository>()
        .publishMessage('cmnd/tasmotas/SetOption19', '0');

    getIt<IMqttServerRepository>()
        .streamOfChosenSubscription('tasmota/discovery/#')
        .listen((mqttPublishMessage) async {
      final String messageTopic = mqttPublishMessage[0].topic;
      final List<String> topicsSplitted = messageTopic.split('/');
      if (topicsSplitted.length < 2) {
        return;
      }
      final String deviceId = topicsSplitted[2];
      final String deviceDeviceTypeThatChanged = topicsSplitted[3];

      final DeviceEntityAbstract? tasmotaDeviceToAdd = await mqttToDevice(
          MapEntry(deviceId,
              {deviceDeviceTypeThatChanged: mqttPublishMessage[0].payload}));

      if (tasmotaDeviceToAdd == null) {
        return;
      }
      bool deviceExist = false;
      for (DeviceEntityAbstract savedDevice in companyDevices.values) {
        savedDevice = savedDevice as TasmotaLedEntity;
        final TasmotaLedEntity tasmotaDeviceAsLed =
            tasmotaDeviceToAdd as TasmotaLedEntity;

        if (tasmotaDeviceAsLed.tasmotaDeviceTopicName.getOrCrash() ==
            savedDevice.tasmotaDeviceTopicName.getOrCrash()) {
          deviceExist = true;
          break;
        }
      }
      if (!deviceExist) {
        print('Adding tasmota device');
        final MapEntry<String, DeviceEntityAbstract> deviceAsEntry = MapEntry(
            tasmotaDeviceToAdd.uniqueId.getOrCrash()!, tasmotaDeviceToAdd);
        companyDevices.addEntries([deviceAsEntry]);

        CompanysConnectorConjector.addDiscoverdDeviceToHub(tasmotaDeviceToAdd);
      }
    });
  }

  static Future<DeviceEntityAbstract?> mqttToDevice(
      MapEntry<String, Map<String, dynamic>> deviceChangeFromMqtt) async {
    DeviceEntityAbstract? tasmotaDeviceToAdd;
    final Map<String, dynamic> devicePropertyAndValues =
        deviceChangeFromMqtt.value;

    for (final String property in devicePropertyAndValues.keys) {
      if (property != 'config') {
        continue;
      }
      final String pt = MqttPublishPayload.bytesToStringAsString(
              (devicePropertyAndValues[property] as MqttPublishMessage)
                  .payload
                  .message)
          .replaceAll('\n', '');
      String deviceTopicName = pt.substring(pt.indexOf('"t":"'));
      deviceTopicName = deviceTopicName.substring(
          deviceTopicName.indexOf(':') + 2, deviceTopicName.indexOf('",'));

      String stateValues = pt.substring(pt.indexOf('state'));
      stateValues = stateValues.substring(
          stateValues.indexOf(':'), stateValues.indexOf('],') + 1);

      if (stateValues.contains('["OFF","ON","TOGGLE","HOLD"]')) {
        // Than device is light or switch
        tasmotaDeviceToAdd = TasmotaLedEntity(
          uniqueId: CoreUniqueId(),
          defaultName: DeviceDefaultName('Tasmota test 1'),
          roomId: CoreUniqueId.newDevicesRoom(),
          roomName: DeviceRoomName(' '),
          deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
          senderDeviceOs: DeviceSenderDeviceOs('Tasmota'),
          senderDeviceModel: DeviceSenderDeviceModel('LED'),
          senderId: DeviceSenderId(),
          compUuid: DeviceCompUuid('34asd233asfdggggg'),
          stateMassage: DeviceStateMassage('Hello World'),
          powerConsumption: DevicePowerConsumption('0'),
          lightSwitchState: GenericLightSwitchState(
              DeviceActions.actionNotSupported.toString()),
          tasmotaDeviceTopicName: TasmotaDeviceTopicName(deviceTopicName),
        );
      }
    }
    return tasmotaDeviceToAdd;
  }

  @override
  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract tasmota) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract tasmota) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<void> manageHubRequestsForDevice(
      DeviceEntityAbstract tasmotaDE) async {
    final DeviceEntityAbstract? device =
        companyDevices[tasmotaDE.getDeviceId()];

    if (device is TasmotaLedEntity) {
      device.executeDeviceAction(tasmotaDE);
    } else {
      print('Tasmota device type does not exist');
    }
    print('manageHubRequestsForDevice in Tasmota');
  }

  @override
  Future<Either<CoreFailure, Unit>> updateDatabase(
      {required String pathOfField,
      required Map<String, dynamic> fieldsToUpdate,
      String? forceUpdateLocation}) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }

  Future<String?> getIpFromMDNS(String deviceMdnsName) async {
    throw UnimplementedError();
  }
}
