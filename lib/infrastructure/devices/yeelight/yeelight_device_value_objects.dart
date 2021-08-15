import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_device_validators.dart';
import 'package:dartz/dartz.dart';

/// Yeelight device unique address that came withe the device
class YeelightDeviceId extends ValueObjectCore<String> {
  factory YeelightDeviceId(String? input) {
    assert(input != null);
    return YeelightDeviceId._(
      validateYeelightIdNotEmpty(input!),
    );
  }

  const YeelightDeviceId._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

/// Yeelight communication port
class YeelightPort extends ValueObjectCore<String> {
  factory YeelightPort(String? input) {
    assert(input != null);
    return YeelightPort._(
      validateYeelightPortNotEmpty(input!),
    );
  }

  const YeelightPort._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
