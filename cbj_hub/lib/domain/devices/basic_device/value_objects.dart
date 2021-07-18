import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/basic_device/devices_validators.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

// class DeviceUniqueId extends ValueObjectCore<String?> {
//   factory DeviceUniqueId() {
//     return DeviceUniqueId._(right(const Uuid().v1()));
//   }
//
//   factory DeviceUniqueId.fromUniqueString(String? uniqueId) {
//     assert(uniqueId != null);
//     return DeviceUniqueId._(right(uniqueId));
//   }
//
//   const DeviceUniqueId._(this.value);
//
//   @override
//   final Either<CoreFailure<String?>, String?> value;
// }

class DeviceRoomName extends ValueObjectCore<String?> {
  factory DeviceRoomName(String? input) {
    return DeviceRoomName._(
      validateRoomNameNotEmpty(input!),
    );
  }

  const DeviceRoomName._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceDefaultName extends ValueObjectCore<String?> {
  factory DeviceDefaultName(String? input) {
    assert(input != null);
    return DeviceDefaultName._(
      validateDeviceNotEmpty(input!)
          .flatMap((a) => validateDeviceMaxNameLength(input, maxLength)),
    );
  }

  const DeviceDefaultName._(this.value);

  @override
  final Either<CoreFailure<String?>, String?> value;

  static const maxLength = 1000;
}

class DeviceState extends ValueObjectCore<String> {
  factory DeviceState(String? input) {
    return DeviceState._(
      validateDeviceNotEmpty(input!)
          .flatMap((a) => validateDeviceStateExist(input)),
    );
  }

  const DeviceState._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceSenderDeviceOs extends ValueObjectCore<String> {
  factory DeviceSenderDeviceOs(String? input) {
    assert(input != null);
    return DeviceSenderDeviceOs._(
      validateDeviceNotEmpty(input!),
    );
  }

  const DeviceSenderDeviceOs._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceStateMassage extends ValueObjectCore<String> {
  factory DeviceStateMassage(String? input) {
    assert(input != null);
    return DeviceStateMassage._(
      validateDeviceNotEmpty(input!),
    );
  }

  const DeviceStateMassage._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceSenderDeviceModel extends ValueObjectCore<String> {
  factory DeviceSenderDeviceModel(String? input) {
    assert(input != null);
    return DeviceSenderDeviceModel._(
      validateDeviceNotEmpty(input!),
    );
  }

  const DeviceSenderDeviceModel._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceSenderId extends ValueObjectCore<String> {
  factory DeviceSenderId() {
    return DeviceSenderId._(right(const Uuid().v1()));
  }

  factory DeviceSenderId.fromUniqueString(String? uniqueId) {
    assert(uniqueId != null);
    return DeviceSenderId._(right(uniqueId!));
  }

  const DeviceSenderId._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceAction extends ValueObjectCore<String> {
  factory DeviceAction(String? input) {
    assert(input != null);

    if (input == 'false') {
      input = DeviceActions.off.toString();
    } else if (input == 'true') {
      input = DeviceActions.on.toString();
    }
    return DeviceAction._(
      validateDeviceNotEmpty(input!)
          .flatMap((a) => validateDeviceActionExist(input!)),
    );
  }

  const DeviceAction._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceType extends ValueObjectCore<String> {
  factory DeviceType(String? input) {
    assert(input != null);
    return DeviceType._(
      validateDeviceNotEmpty(input!)
          .flatMap((a) => validateDeviceTypeExist(input)),
    );
  }

  const DeviceType._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceCompUuid extends ValueObjectCore<String> {
  factory DeviceCompUuid(String? input) {
    assert(input != null);
    return DeviceCompUuid._(
      validateDeviceNotEmpty(input!),
    );
  }

  const DeviceCompUuid._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceLastKnownIp extends ValueObjectCore<String> {
  factory DeviceLastKnownIp(String? input) {
    assert(input != null);
    return DeviceLastKnownIp._(
      validateLastKnownIpNotEmpty(input!),
    );
  }

  const DeviceLastKnownIp._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DevicePowerConsumption extends ValueObjectCore<String> {
  factory DevicePowerConsumption(String input) {
    assert(input != null);
    return DevicePowerConsumption._(
      validatePowerConsumptionNotEmpty(input),
    );
  }

  const DevicePowerConsumption._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceMdnsName extends ValueObjectCore<String> {
  factory DeviceMdnsName(String? input) {
    assert(input != null);
    return DeviceMdnsName._(
      validateMdnsNameNotEmpty(input!),
    );
  }

  const DeviceMdnsName._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class DeviceSecondWiFiName extends ValueObjectCore<String> {
  factory DeviceSecondWiFiName(String? input) {
    assert(input != null);
    return DeviceSecondWiFiName._(
      validateWiFiNameNotEmpty(input!),
    );
  }

  const DeviceSecondWiFiName._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
