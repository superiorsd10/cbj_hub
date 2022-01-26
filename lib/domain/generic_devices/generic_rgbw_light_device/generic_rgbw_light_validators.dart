import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateGenericRgbwLightStateNotEmpty(
  String input,
) {
  return right(input);
}

Either<CoreFailure<String>, String> validateGenericRgbwLightStringNotEmpty(
  String input,
) {
  return right(input);
}

Either<CoreFailure<String>, String>
    validateGenericRgbwLightColorTemperatureNotEmpty(String input) {
  return right(input);
}

Either<CoreFailure<String>, String> validateGenericRgbwLightBrightnessNotEmpty(
  String input,
) {
  return right(input);
}

Either<CoreFailure<String>, String> validateGenericRgbwLightAlphaNotEmpty(
  String input,
) {
  return right(input);
}

Either<CoreFailure<String>, String> validateGenericRgbwLightStringIsDouble(
  String input,
) {
  if (double.tryParse(input) != null) {
    return right(input);
  } else {
    return left(CoreFailure.empty(failedValue: input));
  }
}
