import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';

abstract class ILocalDbRepository {
  void saveSmartDevices(List<DeviceEntity> deviceList);
  List<DeviceEntityAbstract> getSmartDevices();
}
