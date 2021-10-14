import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_gpx3021gl/xiaomi_io_gpx3021gl_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class XiaomiIoConnectorConjector implements AbstractCompanyConnectorConjector {
  XiaomiIoConnectorConjector() {
    _discoverNewDevices();
  }

  @override
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> _discoverNewDevices() async {
    // try {
    //   final InternetAddress internetAddress = InternetAddress('192.168.31.255');
    //
    //   await for (final tup.Tuple2<InternetAddress, MiIoPacket> miDevice
    //       in MiIo.instance.discover(internetAddress)) {
    //     print('miDevice devices $miDevice');
    //     // MiIo.instance.send(address, packet);
    //   }
    //
    //   // final InternetAddress internetAddress = InternetAddress('192.168.31.247');
    //   //
    //   // MiIoPacket a = await MiIo.instance.hello(internetAddress);
    //   // MiIoPacket ab = await MiIo.instance.send(internetAddress, a);
    //   // print('This is mi packets $a');
    // } on MiIoError catch (e) {
    //   logger.e(
    //     'Command failed with error from xiaomi device:\n'
    //     'code: ${e.code}\n'
    //     'message: ${e.message}',
    //   );
    // } on Exception catch (e) {
    //   logger.e('Xiaomi command failed with exception:\n$e');
    // } catch (e) {
    //   print('All else');
    // }
  }

  @override
  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract xiaomiIo) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract xiaomiIo) {
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
    DeviceEntityAbstract xiaomiDE,
  ) async {
    final DeviceEntityAbstract? device = companyDevices[xiaomiDE.getDeviceId()];

    if (device is XiaomiIoGpx4021GlEntity) {
      device.executeDeviceAction(xiaomiDE);
    } else {
      print('XiaomiIo device type does not exist');
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> updateDatabase(
      {required String pathOfField,
      required Map<String, dynamic> fieldsToUpdate,
      String? forceUpdateLocation}) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }
}
