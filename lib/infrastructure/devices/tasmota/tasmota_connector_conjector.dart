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
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';

@singleton
class TasmotaConnectorConjector implements AbstractCompanyConnectorConjector {
  TasmotaConnectorConjector() {
    discoverNewDevices();
  }

  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> discoverNewDevices() async {
    getIt<IMqttServerRepository>()
        .streamOfChosenSubscription('tasmota/discovery/+/config')
        .listen((mqttPublishMessage) async {
      final String messageTopic = mqttPublishMessage[0].topic;

      final List<String> topicsSplitted = messageTopic.split('/');

      final String deviceId = topicsSplitted[2];

      bool deviceExist = false;
      for (DeviceEntityAbstract savedDevice in companyDevices.values) {
        savedDevice = savedDevice as TasmotaLedEntity;

        if (deviceId == savedDevice.vendorUniqueId.getOrCrash()) {
          deviceExist = true;
          break;
        }
      }
      if (deviceExist) {
        return;
      }

      final DeviceEntityAbstract? tasmotaDeviceToAdd = await mqttToDevice(
        MapEntry(messageTopic, mqttPublishMessage[0].payload),
      );

      if (tasmotaDeviceToAdd == null) {
        return;
      }
      logger.v('Adding tasmota device');
      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry = MapEntry(
        tasmotaDeviceToAdd.uniqueId.getOrCrash(),
        tasmotaDeviceToAdd,
      );
      companyDevices.addEntries([deviceAsEntry]);

      CompanysConnectorConjector.addDiscoverdDeviceToHub(tasmotaDeviceToAdd);
    });

    /// Make all tasmota devices repost themselves under topic discovery
    /// in the MQTT broker
    getIt<IMqttServerRepository>()
        .publishMessage('cmnd/tasmotas/SetOption19', '0');
  }

  static Future<DeviceEntityAbstract?> mqttToDevice(
    MapEntry<String, dynamic> deviceChangeFromMqtt,
  ) async {
    final List<String> topicsSplitted = deviceChangeFromMqtt.key.split('/');
    if (topicsSplitted.length < 3) {
      return null;
    }
    final String deviceId = topicsSplitted[2];

    if (topicsSplitted[3] != 'config') {
      return null;
    }

    final String pt = MqttPublishPayload.bytesToStringAsString(
      (deviceChangeFromMqtt.value as MqttPublishMessage).payload.message,
    ).replaceAll('\n', '');

    final String deviceTopic = getValueFromMqttResult(pt, '"t"')!;

    final String? mac = getValueFromMqttResult(pt, 'mac');

    /// Check if this is result full of info and not just response for action
    if (mac == null) {
      return null;
    }

    final String name = getValueFromMqttResult(pt, 'dn')!;

    final DeviceActions deviceActions = DeviceActions.actionNotSupported;

    return TasmotaLedEntity(
      uniqueId: CoreUniqueId(),
      vendorUniqueId: VendorUniqueId(),
      defaultName: DeviceDefaultName(name),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('Tasmota'),
      senderDeviceModel: DeviceSenderDeviceModel('LED'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid(mac),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      lightSwitchState: GenericLightSwitchState(deviceActions.toString()),
      tasmotaDeviceTopicName: TasmotaDeviceTopicName(deviceTopic),
    );
  }

  static String? getValueFromMqttResult(String result, String valueName) {
    String value;
    try {
      value = result.substring(result.indexOf(valueName));
      value = value.substring(value.indexOf(':') + 2, value.indexOf(',') - 1);
    } catch (e) {
      return null;
    }
    return value;
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract tasmota) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract tasmota) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract tasmotaDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[tasmotaDE.getDeviceId()];

    if (device is TasmotaLedEntity) {
      device.executeDeviceAction(newEntity: tasmotaDE);
    } else {
      logger.w('Tasmota device type does not exist');
    }
    logger.v('manageHubRequestsForDevice in Tasmota');
  }

  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  }) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }

  Future<String?> getIpFromMDNS(String deviceMdnsName) async {
    throw UnimplementedError();
  }
}
