import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';

abstract class ILocalDbRepository {
  void saveSmartDevices(List<DeviceEntityAbstract> deviceList);

  Map<String, DeviceEntityAbstract> getSmartDevicesFromDb();
}
