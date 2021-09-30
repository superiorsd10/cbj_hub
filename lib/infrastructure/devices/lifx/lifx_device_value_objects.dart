import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/lifx/lifx_device_validators.dart';
import 'package:dartz/dartz.dart';

/// Lifx device unique address that came withe the device
class LifxDeviceId extends ValueObjectCore<String> {
  factory LifxDeviceId(String? input) {
    assert(input != null);
    return LifxDeviceId._(
      validateLifxIdNotEmpty(input!),
    );
  }

  const LifxDeviceId._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

/// Lifx communication port
class LifxPort extends ValueObjectCore<String> {
  factory LifxPort(String? input) {
    assert(input != null);
    return LifxPort._(
      validateLifxPortNotEmpty(input!),
    );
  }

  const LifxPort._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
