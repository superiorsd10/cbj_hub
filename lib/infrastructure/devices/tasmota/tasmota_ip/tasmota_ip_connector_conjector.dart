import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_ip/tasmota_ip_led/tasmota_ip_led_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:network_tools/network_tools.dart';

@singleton
class TasmotaIpConnectorConjector implements AbstractCompanyConnectorConjector {
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> addNewDeviceByHostInfo({
    required ActiveHost activeHost,
    required String hostName,
  }) async {
    // http://ip/cm?cmnd=SetOption19%200
    // http://ip/cm?cmnd=MqttHost%200

    // TODO: Find all device components so that it can choose which cbj
    // ToODO: entity to create for each component.
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract tasmotaIpDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[tasmotaIpDE.getDeviceId()];

    if (device is TasmotaIpLedEntity) {
      device.executeDeviceAction(newEntity: tasmotaIpDE);
    } else {
      logger.w('TasmotaIp device type does not exist');
    }
    logger.v('manageHubRequestsForDevice in TasmotaIp');
  }
}
