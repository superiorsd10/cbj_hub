import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_validators.dart';
import 'package:dartz/dartz.dart';

class GenericLightSwitchKey extends ValueObjectCore<String> {
  factory GenericLightSwitchKey(String? input) {
    assert(input != null);
    return GenericLightSwitchKey._(
      validateESPHomeSwitchKeyNotEmpty(input!),
    );
  }

  const GenericLightSwitchKey._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
