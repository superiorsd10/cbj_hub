import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/rooms/rooms_failures.dart';
import 'package:dartz/dartz.dart';

Either<RoomsFailure<String>, String> validateRoomsNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(
      RoomsFailure.empty(
        failedValue: input,
      ),
    );
  }
}

Either<RoomsFailure<String>, String> validateLastKnownIpNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(
      RoomsFailure.empty(
        failedValue: input,
      ),
    );
  }
}

Either<RoomsFailure<String>, String> validatePowerConsumptionNotEmpty(
  String input,
) {
  if (double.tryParse(input) != null) {
    return right(input);
  } else {
    return left(const RoomsFailure.powerConsumptionIsNotNumber());
  }
}

Either<RoomsFailure<String>, String> validateRoomNameNotEmpty(String input) {
  if (input != null) {
    return right(input);
  } else {
    return left(RoomsFailure.empty(failedValue: input));
  }
}

Either<RoomsFailure<String>, String> validateMdnsNameNotEmpty(String input) {
  if (input != null) {
    return right(input);
  } else {
    return left(RoomsFailure.empty(failedValue: input));
  }
}

Either<RoomsFailure<String>, String> validateWiFiNameNotEmpty(String input) {
  if (input != null) {
    return right(input);
  } else {
    return left(RoomsFailure.empty(failedValue: input));
  }
}

Either<RoomsFailure<String>, String> validateRoomsMaxNameLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      RoomsFailure.exceedingLength(
        failedValue: input,
        max: maxLength,
      ),
    );
  }
}

Either<RoomsFailure<String>, String> validateRoomsStateExist(String input) {
  if (EnumHelper.stringToRoomsState(input) != null) {
    return right(input);
  }
  return left(const RoomsFailure.roomsActionDoesNotExist());
}

Either<RoomsFailure<String>, String> validateRoomsActionExist(String input) {
  if (EnumHelper.stringToRoomsAction(input) != null) {
    return right(input);
  }
  return left(const RoomsFailure.roomsActionDoesNotExist());
}

Either<RoomsFailure<String>, String> validateRoomsTypeExist(String input) {
  if (EnumHelper.stringToDt(input) != null) {
    return right(input);
  }
  return left(const RoomsFailure.roomsTypeDoesNotExist());
}

Either<RoomsFailure<String>, String> validateRoomsVendorExist(String input) {
  if (EnumHelper.stringToRoomsVendor(input) != null) {
    return right(input);
  }
  return left(const RoomsFailure.roomsTypeDoesNotExist());
}
