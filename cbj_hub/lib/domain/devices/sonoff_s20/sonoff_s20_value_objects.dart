import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_validators.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class SonoffS20RoomName extends ValueObjectCore<String?> {
  factory SonoffS20RoomName(String? input) {
    return SonoffS20RoomName._(
      validateSonoffS20RoomNameNotEmpty(input!),
    );
  }

  const SonoffS20RoomName._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20DefaultName extends ValueObjectCore<String?> {
  factory SonoffS20DefaultName(String? input) {
    assert(input != null);
    return SonoffS20DefaultName._(
      validateSonoffS20NotEmpty(input!)
          .flatMap((a) => validateSonoffS20MaxNameLength(input, maxLength)),
    );
  }

  const SonoffS20DefaultName._(this.value);

  @override
  final Either<CoreFailure<String?>, String?> value;

  static const maxLength = 1000;
}

class SonoffS20State extends ValueObjectCore<String> {
  factory SonoffS20State(String? input) {
    return SonoffS20State._(
      validateSonoffS20NotEmpty(input!)
          .flatMap((a) => validateSonoffS20StateExist(input)),
    );
  }

  const SonoffS20State._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20SenderDeviceOs extends ValueObjectCore<String> {
  factory SonoffS20SenderDeviceOs(String? input) {
    assert(input != null);
    return SonoffS20SenderDeviceOs._(
      validateSonoffS20NotEmpty(input!),
    );
  }

  const SonoffS20SenderDeviceOs._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20StateMassage extends ValueObjectCore<String> {
  factory SonoffS20StateMassage(String? input) {
    assert(input != null);
    return SonoffS20StateMassage._(
      validateSonoffS20NotEmpty(input!),
    );
  }

  const SonoffS20StateMassage._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20SenderDeviceModel extends ValueObjectCore<String> {
  factory SonoffS20SenderDeviceModel(String? input) {
    assert(input != null);
    return SonoffS20SenderDeviceModel._(
      validateSonoffS20NotEmpty(input!),
    );
  }

  const SonoffS20SenderDeviceModel._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20SenderId extends ValueObjectCore<String> {
  factory SonoffS20SenderId() {
    return SonoffS20SenderId._(right(const Uuid().v1()));
  }

  factory SonoffS20SenderId.fromUniqueString(String? uniqueId) {
    assert(uniqueId != null);
    return SonoffS20SenderId._(right(uniqueId!));
  }

  const SonoffS20SenderId._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20Action extends ValueObjectCore<String> {
  factory SonoffS20Action(String? input) {
    assert(input != null);

    if (input == 'false') {
      input = DeviceActions.off.toString();
    } else if (input == 'true') {
      input = DeviceActions.on.toString();
    }
    return SonoffS20Action._(
      validateSonoffS20NotEmpty(input!)
          .flatMap((a) => validateSonoffS20ActionExist(input!)),
    );
  }

  const SonoffS20Action._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20Type extends ValueObjectCore<String> {
  factory SonoffS20Type(String? input) {
    assert(input != null);
    return SonoffS20Type._(
      validateSonoffS20NotEmpty(input!)
          .flatMap((a) => validateSonoffS20TypeExist(input)),
    );
  }

  const SonoffS20Type._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20CompUuid extends ValueObjectCore<String> {
  factory SonoffS20CompUuid(String? input) {
    assert(input != null);
    return SonoffS20CompUuid._(
      validateSonoffS20NotEmpty(input!),
    );
  }

  const SonoffS20CompUuid._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20LastKnownIp extends ValueObjectCore<String> {
  factory SonoffS20LastKnownIp(String? input) {
    assert(input != null);
    return SonoffS20LastKnownIp._(
      validateSonoffS20LastKnownIpNotEmpty(input!),
    );
  }

  const SonoffS20LastKnownIp._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20PowerConsumption extends ValueObjectCore<String> {
  factory SonoffS20PowerConsumption(String input) {
    assert(input != null);
    return SonoffS20PowerConsumption._(
      validateCoreFailurePowerConsumptionNotEmpty(input),
    );
  }

  const SonoffS20PowerConsumption._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20MdnsName extends ValueObjectCore<String> {
  factory SonoffS20MdnsName(String? input) {
    assert(input != null);
    return SonoffS20MdnsName._(
      validateSonoffS20MdnsNameNotEmpty(input!),
    );
  }

  const SonoffS20MdnsName._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20SecondWiFiName extends ValueObjectCore<String> {
  factory SonoffS20SecondWiFiName(String? input) {
    assert(input != null);
    return SonoffS20SecondWiFiName._(
      validateSonoffS20WiFiNameNotEmpty(input!),
    );
  }

  const SonoffS20SecondWiFiName._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

class SonoffS20SwitchKey extends ValueObjectCore<String> {
  factory SonoffS20SwitchKey(String? input) {
    assert(input != null);
    return SonoffS20SwitchKey._(
      validateSonoffS20SwitchKeyNotEmpty(input!),
    );
  }

  const SonoffS20SwitchKey._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
