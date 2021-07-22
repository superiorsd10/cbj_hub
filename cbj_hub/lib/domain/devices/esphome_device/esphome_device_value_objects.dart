import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:dartz/dartz.dart';

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
