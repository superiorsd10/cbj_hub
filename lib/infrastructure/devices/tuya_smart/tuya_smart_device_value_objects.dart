import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/tuya_smart/tuya_smart_device_validators.dart';
import 'package:dartz/dartz.dart';

/// TuyaSmart device unique address that came withe the device
class TuyaSmartDeviceId extends ValueObjectCore<String> {
  factory TuyaSmartDeviceId(String? input) {
    assert(input != null);
    return TuyaSmartDeviceId._(
      validateTuyaSmartIdNotEmpty(input!),
    );
  }

  const TuyaSmartDeviceId._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

/// TuyaSmart communication port
class TuyaSmartPort extends ValueObjectCore<String> {
  factory TuyaSmartPort(String? input) {
    assert(input != null);
    return TuyaSmartPort._(
      validateTuyaSmartPortNotEmpty(input!),
    );
  }

  const TuyaSmartPort._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
