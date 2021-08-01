import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_validators.dart';
import 'package:dartz/dartz.dart';

class YeelightSwitchKey extends ValueObjectCore<String> {
  factory YeelightSwitchKey(String? input) {
    assert(input != null);
    return YeelightSwitchKey._(
      validateYeelightSwitchKeyNotEmpty(input!),
    );
  }

  const YeelightSwitchKey._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
