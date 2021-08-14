import 'dart:async';

import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class TasmotaConnectorConjector implements AbstractCompanyConnectorConjector {
  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

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
  Future<void> executeDeviceAction(DeviceEntityAbstract tasmotaDE) async {
    if (tasmotaDE is GenericLightDE) {
      final GenericLightDE tasmotaDELight = tasmotaDE;
      final DeviceActions? actionToPreform = EnumHelper.stringToDeviceAction(
          tasmotaDELight.lightSwitchState!.getOrCrash());

      companyDevices[tasmotaDELight.uniqueId.getOrCrash()!] =
          (companyDevices[tasmotaDELight.uniqueId.getOrCrash()!]!
              as GenericLightDE)
            ..lightSwitchState =
                GenericLightSwitchState(actionToPreform.toString());

      if (actionToPreform == DeviceActions.on) {
        (await turnOntasmota(tasmotaDELight)).fold(
            (l) => print('Error turning light on'),
            (r) => print('Light turn on success'));
      } else if (actionToPreform == DeviceActions.off) {
        (await turnOfftasmota(tasmotaDELight)).fold(
            (l) => print('Error turning light off'),
            (r) => print('Light turn off success'));
      }
    }
  }

  @override
  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  @override
  Future<void> manageHubRequestsForDevice(
      DeviceEntityAbstract tasmotaDE) async {
    final GenericLightDE? device =
        companyDevices[tasmotaDE.getDeviceId()] as GenericLightDE;
    if (device == null) {
      print('Cant change Yeelight, does not exist');
      return;
    }

    if (tasmotaDE.getDeviceId() == device.getDeviceId()) {
      if ((tasmotaDE as GenericLightDE).lightSwitchState !=
          device.lightSwitchState) {
        executeDeviceAction(tasmotaDE);
      } else {
        print('No changes for Yeelight');
      }
      return;
    }
    print('manageHubRequestsForDevice in Yeelight');
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOfftasmota(
      GenericLightDE tasmotaDE) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOntasmota(
      GenericLightDE tasmotaDE) async {
    throw UnimplementedError();
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
