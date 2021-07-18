import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_validators.dart';
import 'package:dartz/dartz.dart';

class SonoffS20SwitchKey extends ValueObjectCore<String> {
  factory SonoffS20SwitchKey(String? input) {
    assert(input != null);
    return SonoffS20SwitchKey._(
      validateSonoffS20SwitchKeyNotEmpty(input!),
    );
  }

  const SonoffS20SwitchKey._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
