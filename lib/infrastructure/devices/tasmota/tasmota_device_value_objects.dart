import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_device_validators.dart';
import 'package:dartz/dartz.dart';

/// Yeelight device unique address that came withe the device
class TasmotaDeviceTopicName extends ValueObjectCore<String> {
  factory TasmotaDeviceTopicName(String? input) {
    assert(input != null);
    return TasmotaDeviceTopicName._(
      validateTasmotaDeviceTopicNameNotEmpty(input!),
    );
  }

  const TasmotaDeviceTopicName._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
