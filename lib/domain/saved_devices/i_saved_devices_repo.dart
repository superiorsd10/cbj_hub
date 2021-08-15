import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';

abstract class ISavedDevicesRepo {
  /// Add new device to saved devices list
  String addOrUpdateDevice(DeviceEntityAbstract deviceEntity);

  /// Get all saved devices
  Future<Map<String, DeviceEntityAbstract>> getAllDevices();
}
