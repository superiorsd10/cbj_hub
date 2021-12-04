import 'package:freezed_annotation/freezed_annotation.dart';

part 'rooms_failures.freezed.dart';

@freezed
class RoomsFailure<T> {
  const factory RoomsFailure.empty({
    required T failedValue,
  }) = _Empty;

  const factory RoomsFailure.actionExcecuter({
    required T failedValue,
  }) = _ActionExcecuter;

  const factory RoomsFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = _ExceedingLength;

  const factory RoomsFailure.unexpected() = _Unexpected;

  const factory RoomsFailure.insufficientPermission() = _InsufficientPermission;

  const factory RoomsFailure.unableToUpdate() = _UnableToUpdate;

  const factory RoomsFailure.powerConsumptionIsNotNumber() =
      _PowerConsumptionIsNotNumber;

  const factory RoomsFailure.roomsActionDoesNotExist() =
      _RoomsActionDoesNotExist;

  const factory RoomsFailure.roomsTypeDoesNotExist() = _RoomsTypeDoesNotExist;
}
