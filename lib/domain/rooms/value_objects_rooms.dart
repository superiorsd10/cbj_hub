import 'package:cbj_hub/domain/rooms/rooms_errors.dart';
import 'package:cbj_hub/domain/rooms/rooms_failures.dart';
import 'package:cbj_hub/domain/rooms/rooms_validators.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class ValueObjectRooms<T> {
  const ValueObjectRooms();

  Either<RoomsFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [AuthValueFailure]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw RoomsUnexpectedValueError(f), id);
  }

  Either<RoomsFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold((l) => left(l), (r) => right(unit));
  }

  bool isValid() => value.isRight();

  @override
  String toString() => 'Value($value)';

  @override
  @nonVirtual
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObjectRooms<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

class RoomsUniqueId extends ValueObjectRooms<String?> {
  factory RoomsUniqueId() {
    return RoomsUniqueId._(right(const Uuid().v1()));
  }

  factory RoomsUniqueId.fromUniqueString(String? uniqueId) {
    assert(uniqueId != null);
    return RoomsUniqueId._(right(uniqueId));
  }

  factory RoomsUniqueId.newRoomsRoom() {
    return RoomsUniqueId._(right('00000000-0000-0000-0000-000000000000'));
  }

  const RoomsUniqueId._(this.value);

  @override
  final Either<RoomsFailure<String?>, String?> value;
}

class RoomsRoomName extends ValueObjectRooms<String?> {
  factory RoomsRoomName(String? input) {
    return RoomsRoomName._(
      validateRoomNameNotEmpty(input!),
    );
  }

  const RoomsRoomName._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsDefaultName extends ValueObjectRooms<String?> {
  factory RoomsDefaultName(String? input) {
    assert(input != null);
    return RoomsDefaultName._(
      validateRoomsNotEmpty(input!)
          .flatMap((a) => validateRoomsMaxNameLength(input, maxLength)),
    );
  }

  const RoomsDefaultName._(this.value);

  @override
  final Either<RoomsFailure<String?>, String?> value;

  static const maxLength = 1000;
}

class RoomsState extends ValueObjectRooms<String> {
  factory RoomsState(String? input) {
    return RoomsState._(
      validateRoomsNotEmpty(input!)
          .flatMap((a) => validateRoomsStateExist(input)),
    );
  }

  const RoomsState._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsSenderRoomsOs extends ValueObjectRooms<String> {
  factory RoomsSenderRoomsOs(String? input) {
    assert(input != null);
    return RoomsSenderRoomsOs._(
      validateRoomsNotEmpty(input!),
    );
  }

  const RoomsSenderRoomsOs._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsStateMassage extends ValueObjectRooms<String> {
  factory RoomsStateMassage(String? input) {
    assert(input != null);
    return RoomsStateMassage._(
      validateRoomsNotEmpty(input!),
    );
  }

  const RoomsStateMassage._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsSenderRoomsModel extends ValueObjectRooms<String> {
  factory RoomsSenderRoomsModel(String? input) {
    assert(input != null);
    return RoomsSenderRoomsModel._(
      validateRoomsNotEmpty(input!),
    );
  }

  const RoomsSenderRoomsModel._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsSenderId extends ValueObjectRooms<String> {
  factory RoomsSenderId() {
    return RoomsSenderId._(right(const Uuid().v1()));
  }

  factory RoomsSenderId.fromUniqueString(String? uniqueId) {
    assert(uniqueId != null);
    return RoomsSenderId._(right(uniqueId!));
  }

  const RoomsSenderId._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsAction extends ValueObjectRooms<String> {
  factory RoomsAction(String? input) {
    assert(input != null);

    if (input == 'false') {
      input = RoomsActions.off.toString();
    } else if (input == 'true') {
      input = RoomsActions.on.toString();
    }
    return RoomsAction._(
      validateRoomsNotEmpty(input!)
          .flatMap((a) => validateRoomsActionExist(input!)),
    );
  }

  const RoomsAction._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsType extends ValueObjectRooms<String> {
  factory RoomsType(String? input) {
    assert(input != null);
    return RoomsType._(
      validateRoomsNotEmpty(input!)
          .flatMap((a) => validateRoomsTypeExist(input)),
    );
  }

  const RoomsType._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsVendor extends ValueObjectRooms<String> {
  factory RoomsVendor(String? input) {
    assert(input != null);
    return RoomsVendor._(
      validateRoomsNotEmpty(input!)
          .flatMap((a) => validateRoomsVendorExist(input)),
    );
  }

  const RoomsVendor._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsCompUuid extends ValueObjectRooms<String> {
  factory RoomsCompUuid(String? input) {
    assert(input != null);
    return RoomsCompUuid._(
      validateRoomsNotEmpty(input!),
    );
  }

  const RoomsCompUuid._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsLastKnownIp extends ValueObjectRooms<String> {
  factory RoomsLastKnownIp(String? input) {
    assert(input != null);
    return RoomsLastKnownIp._(
      validateLastKnownIpNotEmpty(input!),
    );
  }

  const RoomsLastKnownIp._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsPowerConsumption extends ValueObjectRooms<String> {
  factory RoomsPowerConsumption(String input) {
    assert(input != null);
    return RoomsPowerConsumption._(
      validatePowerConsumptionNotEmpty(input),
    );
  }

  const RoomsPowerConsumption._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsMdnsName extends ValueObjectRooms<String> {
  factory RoomsMdnsName(String? input) {
    assert(input != null);
    return RoomsMdnsName._(
      validateMdnsNameNotEmpty(input!),
    );
  }

  const RoomsMdnsName._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}

class RoomsSecondWiFiName extends ValueObjectRooms<String> {
  factory RoomsSecondWiFiName(String? input) {
    assert(input != null);
    return RoomsSecondWiFiName._(
      validateWiFiNameNotEmpty(input!),
    );
  }

  const RoomsSecondWiFiName._(this.value);

  @override
  final Either<RoomsFailure<String>, String> value;
}
