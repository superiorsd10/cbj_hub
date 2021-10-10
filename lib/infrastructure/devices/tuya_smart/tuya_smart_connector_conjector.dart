import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_helpers.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_jbt_a70_rgbcw_wf/tuya_smart_jbt_a70_rgbcw_wf_entity.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/cloudtuya.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_remote_api/tuya_device_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_switch/tuya_smart_switch_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class TuyaSmartConnectorConjector implements AbstractCompanyConnectorConjector {
  Future<String> accountLogin(GenericTuyaLoginDE genericTuyaLoginDE) async {
    cloudTuya = CloudTuya(
      userName: genericTuyaLoginDE.tuyaUserName.getOrCrash(),
      userPassword: genericTuyaLoginDE.tuyaUserPassword.getOrCrash(),
      countryCode: genericTuyaLoginDE.tuyaCountryCode.getOrCrash(),
      bizType: genericTuyaLoginDE.tuyaBizType.getOrCrash(),
      region: genericTuyaLoginDE.tuyaRegion.getOrCrash(),
    );
    _discoverNewDevices();
    return 'Success';
  }

  static late CloudTuya cloudTuya;

  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> _discoverNewDevices() async {
    while (true) {
      try {
        final List<TuyaDeviceAbstract> deviceList =
            await cloudTuya.findDevices();

        for (final TuyaDeviceAbstract tuyaDevice in deviceList) {
          bool deviceExist = false;
          for (final DeviceEntityAbstract savedDevice
              in companyDevices.values) {
            if (savedDevice is TuyaSmartJbtA70RgbcwWfEntity) {
              if (tuyaDevice.id ==
                  savedDevice.tuyaSmartDeviceId!.getOrCrash()) {
                deviceExist = true;
                break;
              }
            } else {
              logger.i('Please add new Tuya device type ${tuyaDevice.haType}');
              break;
            }
          }
          if (!deviceExist) {
            final DeviceEntityAbstract addDevice =
                TuyaSmartHelpers.addDiscoverdDevice(tuyaDevice);
            CompanysConnectorConjector.addDiscoverdDeviceToHub(addDevice);
            final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
                MapEntry(addDevice.uniqueId.getOrCrash()!, addDevice);
            companyDevices.addEntries([deviceAsEntry]);

            CompanysConnectorConjector.addDiscoverdDeviceToHub(addDevice);
            logger.i('New Tuya devices where add');
          }
        }
        await Future.delayed(const Duration(minutes: 3));
      } catch (e) {
        logger.e('Error discover in Tuya $e');
        await Future.delayed(const Duration(minutes: 1));
      }
    }
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract tuyaSmart) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract tuyaSmart) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract tuyaSmartDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[tuyaSmartDE.getDeviceId()];

    if (device is TuyaSmartJbtA70RgbcwWfEntity) {
      device.executeDeviceAction(tuyaSmartDE);
    } else if (device is TuyaSmartSwitchEntity) {
      device.executeDeviceAction(tuyaSmartDE);
    } else {
      logger.w('TuyaSmart device type does not exist');
    }
  }

  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  }) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }
}
