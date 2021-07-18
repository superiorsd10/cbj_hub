import 'package:cbj_hub/domain/devices/abstract_device/core_errors.dart';
import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class ValueObjectCore<T> {
  const ValueObjectCore();

  Either<CoreFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [AuthValueFailure]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw CoreUnexpectedValueError(f), id);
  }

  Either<CoreFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold((l) => left(l), (r) => right(unit));
  }

  bool isValid() => value.isRight();

  @override
  String toString() => 'Value($value)';

  @override
  @nonVirtual
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObjectCore<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

class CoreUniqueId extends ValueObjectCore<String?> {
  factory CoreUniqueId() {
    return CoreUniqueId._(right(const Uuid().v1()));
  }

  factory CoreUniqueId.fromUniqueString(String? uniqueId) {
    assert(uniqueId != null);
    return CoreUniqueId._(right(uniqueId));
  }

  const CoreUniqueId._(this.value);

  @override
  final Either<CoreFailure<String?>, String?> value;
}
