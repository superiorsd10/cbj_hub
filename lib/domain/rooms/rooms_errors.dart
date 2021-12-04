import 'package:cbj_hub/domain/rooms/rooms_failures.dart';

class RoomsUnexpectedValueError extends Error {
  RoomsUnexpectedValueError(this.roomsValueFailure);

  final RoomsFailure roomsValueFailure;

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $roomsValueFailure');
  }
}
