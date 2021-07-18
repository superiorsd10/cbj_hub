import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateSonoffS20NotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(CoreFailure.empty(
      failedValue: input,
    ));
  }
}

Either<CoreFailure<String>, String> validateSonoffS20LastKnownIpNotEmpty(
    String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(CoreFailure.empty(
      failedValue: input,
    ));
  }
}

Either<CoreFailure<String>, String> validateCoreFailurePowerConsumptionNotEmpty(
    String input) {
  if (double.tryParse(input) != null) {
    return right(input);
  } else {
    return left(const CoreFailure.powerConsumptionIsNotNumber());
  }
}

Either<CoreFailure<String>, String> validateSonoffS20RoomNameNotEmpty(
    String input) {
  if (input != null) {
    return right(input);
  } else {
    return left(CoreFailure.empty(failedValue: input));
  }
}

Either<CoreFailure<String>, String> validateSonoffS20MdnsNameNotEmpty(
    String input) {
  if (input != null) {
    return right(input);
  } else {
    return left(CoreFailure.empty(failedValue: input));
  }
}

Either<CoreFailure<String>, String> validateSonoffS20WiFiNameNotEmpty(
    String input) {
  if (input != null) {
    return right(input);
  } else {
    return left(CoreFailure.empty(failedValue: input));
  }
}

Either<CoreFailure<String>, String> validateSonoffS20SwitchKeyNotEmpty(
    String input) {
  if (input != null) {
    return right(input);
  } else {
    return left(CoreFailure.empty(failedValue: input));
  }
}

Either<CoreFailure<String>, String> validateSonoffS20MaxNameLength(
    String input, int maxLength) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(CoreFailure.exceedingLength(
      failedValue: input,
      max: maxLength,
    ));
  }
}

Either<CoreFailure<String>, String> validateSonoffS20StateExist(String input) {
  if (EnumHelper.stringToDeviceState(input) != null) {
    return right(input);
  }
  return left(const CoreFailure.deviceActionDoesNotExist());
}

Either<CoreFailure<String>, String> validateSonoffS20ActionExist(String input) {
  if (EnumHelper.stringToDeviceAction(input) != null) {
    return right(input);
  }
  return left(const CoreFailure.deviceActionDoesNotExist());
}

Either<CoreFailure<String>, String> validateSonoffS20TypeExist(String input) {
  if (EnumHelper.stringToDt(input) != null) {
    return right(input);
  }
  return left(const CoreFailure.deviceTypeDoesNotExist());
}
