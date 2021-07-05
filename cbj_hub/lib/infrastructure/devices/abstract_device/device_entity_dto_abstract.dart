import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/basic_device/device_dtos.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_s20/sonoff_s20_dtos.dart';

class DeviceEntityDtoAbstract {
  DeviceEntityDtoAbstract();

  final String deviceDtoClassInstance = (DeviceEntityDtoAbstract).toString();

  factory DeviceEntityDtoAbstract.fromDomain() {
    print('DeviceEntityDtoAbstract.fromDomain');
    return DeviceEntityDtoAbstract();
  }

  factory DeviceEntityDtoAbstract.fromJson(Map<String, dynamic> json) {
    DeviceEntityDtoAbstract deviceEntityDtoAbstract = DeviceEntityDtoAbstract();
    final String jsonDeviceDtoClass = json['deviceDtoClass'].toString();

    if (jsonDeviceDtoClass == (DeviceDtos).toString()) {
      deviceEntityDtoAbstract = DeviceDtos.fromJson(json);
    } else if (jsonDeviceDtoClass == (SonoffS20Dtos).toString()) {
      deviceEntityDtoAbstract = SonoffS20Dtos.fromJson(json);
    } else {
      throw 'DtoClassTypeDoesNotExist';
    }
    return deviceEntityDtoAbstract;
  }

  Map<String, dynamic> toJson() {
    print('DeviceEntityDtoAbstract to Json');
    return {};
  }

  DeviceEntityAbstract toDomain() {
    print('ToDomain');
    return DeviceEntityAbstract();
  }
}
