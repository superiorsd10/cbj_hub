import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';

abstract class ISavedDevicesRepo {
  /// Add new device to saved devices list
  String addNewDevice();

  /// Get all saved devices
  Future<List<DeviceEntityAbstract>> getAllDevices();
}
