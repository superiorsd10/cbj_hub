import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateTuyaSmartIdNotEmpty(String input) {
  if (input != null) {
    return right(input);
  } else {
    return left(CoreFailure.empty(failedValue: input));
  }
}

Either<CoreFailure<String>, String> validateTuyaSmartPortNotEmpty(
  String input,
) {
  if (input != null) {
    return right(input);
  } else {
    return left(CoreFailure.empty(failedValue: input));
  }
}
