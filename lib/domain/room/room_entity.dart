import 'package:cbj_hub/domain/room/room_failures.dart';
import 'package:cbj_hub/domain/room/value_objects_room.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'room_entity.freezed.dart';

@freezed
abstract class RoomEntity implements _$RoomEntity {
  const factory RoomEntity({
    required RoomUniqueId uniqueId,
    required RoomDefaultName defaultName,
    RoomTypes? roomTypes,
    RoomDevicesId? roomDevicesId,
    /// Who is using this room
    RoomMostUsedBy? roomMostUsedBy,
    /// Room permissions by users id
    RoomPermissions? roomPermissions,
  }) = _RoomEntity;

  const RoomEntity._();

  factory RoomEntity.empty() => RoomEntity(
    uniqueId: RoomUniqueId.discoveredRoomId(),
    defaultName: RoomDefaultName(''),
  );

  Option<RoomFailure<dynamic>> get failureOption {
    return defaultName.value.fold((f) => some(f), (_) => none());
  }
}
