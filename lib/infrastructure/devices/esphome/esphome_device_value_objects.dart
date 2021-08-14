import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_device_validators.dart';
import 'package:dartz/dartz.dart';

/// ESPHome device unique address that came withe the device
class ESPHomeSwitchKey extends ValueObjectCore<String> {
  factory ESPHomeSwitchKey(String? input) {
    assert(input != null);
    return ESPHomeSwitchKey._(
      validateESPHomeSwitchKeyNotEmpty(input!),
    );
  }

  const ESPHomeSwitchKey._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
