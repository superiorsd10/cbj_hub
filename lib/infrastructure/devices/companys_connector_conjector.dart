import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/vendors/lifx_login/generic_lifx_login_entity.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';

class CompanysConnectorConjector {
  static void updateAllDevicesReposWithDeviceChanges(
    Stream<dynamic> allDevices,
  ) {
    allDevices.listen((deviceEntityAbstract) {
      if (deviceEntityAbstract is DeviceEntityAbstract) {
        final String deviceVendor =
            deviceEntityAbstract.deviceVendor.getOrCrash();
        if (deviceVendor == VendorsAndServices.yeelight.toString()) {
          YeelightConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.tasmota.toString()) {
          TasmotaConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.espHome.toString()) {
          ESPHomeConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor ==
            VendorsAndServices.switcherSmartHome.toString()) {
          SwitcherConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.google.toString()) {
          GoogleConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.miHome.toString()) {
          XiaomiIoConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.tuyaSmart.toString()) {
          TuyaSmartConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else if (deviceVendor == VendorsAndServices.lifx.toString()) {
          LifxConnectorConjector()
              .manageHubRequestsForDevice(deviceEntityAbstract);
        } else {
          logger.i(
            'Cannot send device changes to its repo, company not supported',
          );
        }
      } else {
        logger.w('Connector conjector got other type');
      }
    });
  }

  static void addAllDevicesToItsRepos(
      Map<String, DeviceEntityAbstract> allDevices) {
    for (final String deviceId in allDevices.keys) {
      final MapEntry<String, DeviceEntityAbstract> currentDeviceMapEntry =
          MapEntry<String, DeviceEntityAbstract>(
        deviceId,
        allDevices[deviceId]!,
      );
      addDeviceToItsRepo(currentDeviceMapEntry);
    }
  }

  static void addDeviceToItsRepo(
    MapEntry<String, DeviceEntityAbstract> deviceEntityAbstract,
  ) {
    final MapEntry<String, DeviceEntityAbstract> devicesEntry =
        MapEntry<String, DeviceEntityAbstract>(
      deviceEntityAbstract.key,
      deviceEntityAbstract.value,
    );

    final String deviceVendor =
        deviceEntityAbstract.value.deviceVendor.getOrCrash();

    if (deviceVendor == VendorsAndServices.yeelight.toString()) {
      YeelightConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.tasmota.toString()) {
      TasmotaConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.espHome.toString()) {
      ESPHomeConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor ==
        VendorsAndServices.switcherSmartHome.toString()) {
      SwitcherConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.google.toString()) {
      GoogleConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.miHome.toString()) {
      XiaomiIoConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.tuyaSmart.toString()) {
      TuyaSmartConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else if (deviceVendor == VendorsAndServices.lifx.toString()) {
      LifxConnectorConjector.companyDevices.addEntries([devicesEntry]);
    } else {
      logger.w('Cannot add device entity to its repo, type not supported');
    }
  }

  static DeviceEntityAbstract addDiscoverdDeviceToHub(
    DeviceEntityAbstract deviceEntity,
  ) {
    return getIt<ISavedDevicesRepo>().addOrUpdateDevice(deviceEntity);
  }

  static void setVendorLoginCredentials(LoginEntityAbstract loginEntity) {
    if (loginEntity is GenericLifxLoginDE) {
      getIt<LifxConnectorConjector>().accountLogin(loginEntity);
    } else if (loginEntity is GenericTuyaLoginDE) {
      getIt<TuyaSmartConnectorConjector>()
          .accountLogin(genericTuyaLoginDE: loginEntity);
    } else {
      logger.w('Vendor login type ${loginEntity.runtimeType} is not supported');
    }
  }
}
