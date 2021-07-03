import 'package:cbj_hub/domain/devices/abstact_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';

class DeviceEntityDtoAbstract {
  DeviceEntityDtoAbstract();

  factory DeviceEntityDtoAbstract.fromDomain() {
    print('DeviceEntityDtoAbstract.fromDomain');
    return DeviceEntityDtoAbstract();
  }

  DeviceEntityAbstract toDomain() {
    print('ToDomain');
    return DeviceEntity.empty();
  }
}
