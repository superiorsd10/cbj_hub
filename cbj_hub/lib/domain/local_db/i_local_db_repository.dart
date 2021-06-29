import 'package:cbj_hub/domain/devices/device_entity.dart';

abstract class ILocalDbRepository {
  void saveSmartDevices(List<DeviceEntity> deviceList);
  List<DeviceEntity> getSmartDevices();
}
