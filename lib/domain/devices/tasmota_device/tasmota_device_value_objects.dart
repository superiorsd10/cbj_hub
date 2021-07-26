import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/tasmota_device/tasmota_device_validators.dart';
import 'package:dartz/dartz.dart';

class TasmotaSwitchKey extends ValueObjectCore<String> {
  factory TasmotaSwitchKey(String? input) {
    assert(input != null);
    return TasmotaSwitchKey._(
      validateTasmotaSwitchKeyNotEmpty(input!),
    );
  }

  const TasmotaSwitchKey._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
