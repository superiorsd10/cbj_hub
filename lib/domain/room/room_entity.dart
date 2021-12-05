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
    required RoomTypes roomTypes,
    required RoomDevicesId roomDevicesId,

    /// Who is using this room
    required RoomMostUsedBy roomMostUsedBy,

    /// Room permissions by users id
    required RoomPermissions roomPermissions,
  }) = _RoomEntity;

  const RoomEntity._();

  factory RoomEntity.empty() => RoomEntity(
        uniqueId: RoomUniqueId(),
        defaultName: RoomDefaultName(''),
        roomDevicesId: RoomDevicesId([]), // Do not add const
        roomMostUsedBy: RoomMostUsedBy([]), // Do not add const
        roomPermissions: RoomPermissions([]), // Do not add const
        roomTypes: RoomTypes([]),
      );

  /// Will add new device id to the devices in the room list
  void addDeviceId(String newDeviceId) {
    /// Will not work if list got created with const
    roomDevicesId.getOrCrash().add(newDeviceId);
  }

  Option<RoomFailure<dynamic>> get failureOption {
    return defaultName.value.fold((f) => some(f), (_) => none());
  }
}
