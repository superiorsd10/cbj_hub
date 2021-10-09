import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_validators.dart';
import 'package:dartz/dartz.dart';

class GenericSwitchState extends ValueObjectCore<String> {
  factory GenericSwitchState(String? input) {
    assert(input != null);
    return GenericSwitchState._(
      validateGenericLightStateNotEmty(input!),
    );
  }

  const GenericSwitchState._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
