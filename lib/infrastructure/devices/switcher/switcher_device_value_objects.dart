import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/switcher/switcher_device_validators.dart';
import 'package:dartz/dartz.dart';

/// Switcher device unique address that came withe the device
class SwitcherDeviceId extends ValueObjectCore<String> {
  factory SwitcherDeviceId(String? input) {
    assert(input != null);
    return SwitcherDeviceId._(
      validateSwitcherIdNotEmpty(input!),
    );
  }

  const SwitcherDeviceId._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

/// Switcher communication port
class SwitcherPort extends ValueObjectCore<String> {
  factory SwitcherPort(String? input) {
    assert(input != null);
    return SwitcherPort._(
      validateSwitcherPortNotEmpty(input!),
    );
  }

  const SwitcherPort._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
