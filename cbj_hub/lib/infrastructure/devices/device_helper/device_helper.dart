import 'dart:convert';

import 'package:cbj_hub/domain/devices/abstact_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_device_entity.dart';
import 'package:cbj_hub/infrastructure/devices/abstact_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/basic_device/device_dtos.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_s20/sonoff_s20_dtos.dart';

class DeviceHelper {
  /// Dtos to json
  static Map<String, dynamic> convertDtoToJson(dynamic deviceEntityDto) {
    Map<String, dynamic> deDtoAsJson = {};
    switch (deviceEntityDto.runtimeType) {
      case DeviceDtos:
        deDtoAsJson = (deviceEntityDto as DeviceDtos).toJson();
        break;
      case SonoffS20Dtos:
        deDtoAsJson = (deviceEntityDto as SonoffS20Dtos).toJson();
        break;
    }

    return deDtoAsJson;
  }

  /// json to Dto
  static dynamic convertJsonToDto(Map<String, dynamic> json) {
    /// TODO: change to the abstract type
    return DeviceDtos.fromJson(json);
  }

  /// json to json string
  static String convertJsonToJsonString(Map<String, dynamic> json) {
    return jsonEncode(json);
  }

  /// string json to json
  static Map<String, dynamic> convertJsonStringToJson(String jsonString) {
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// Device entity to dto
  static DeviceEntityDtoAbstract convertDomainToDto(
      DeviceEntityAbstract deviceEntity) {
    DeviceEntityDtoAbstract deviceDto;

    if (deviceEntity is DeviceEntity) {
      deviceDto = DeviceDtos.fromDomain(deviceEntity);
    } else if (deviceEntity is SonoffS20DE) {
      deviceDto = SonoffS20Dtos.fromDomain(deviceEntity);
    } else {
      throw 'detos abstract is null';
    }

    return deviceDto;
  }

  /// Dto to device entity
  static DeviceEntityAbstract convertDtoToDomain(
      DeviceEntityDtoAbstract deviceEntityDto) {
    DeviceEntityAbstract deviceDto = deviceEntityDto.toDomain();

    // a.toDomain();
    //
    // switch (deviceEntityDto.runtimeType) {
    //   case DeviceDtos:
    //     deviceDto = deviceEntityDto.toDomain();
    //     break;
    //   case SonoffS20Dtos:
    //     deviceDto = (deviceEntityDto as SonoffS20Dtos).toDomain();
    //     break;
    // }

    return deviceDto;
  }

  // Extras methods
  // static dynamic convertJsonToDomain(Map<String, dynamic> json) {
  //   return convertDtoToDomain(convertJsonToDto(json));
  // }

  // static Map<String, dynamic> convertDomainToJson(dynamic deviceEntity) {
  //   return convertDtosToJson(convertDomainToDto(deviceEntity));
  // }
}
