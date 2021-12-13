import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/remote_pipes/remote_pipes_entity.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:dartz/dartz.dart';

abstract class ISavedDevicesRepo {
  DeviceEntityAbstract? addOrUpdateFromMqtt(dynamic updateFromMqtt);

  /// Add new device to saved devices list
  DeviceEntityAbstract addOrUpdateDevice(DeviceEntityAbstract deviceEntity);

  /// Add new room to saved rooms list
  String addOrUpdateRoom(RoomEntity roomEntity);

  Future<Either<LocalDbFailures, Unit>> saveAndActiveRoomToDb({
    required RoomEntity roomEntity,
  });

  /// Will save the remote pipes entity to the local storage and will activate
  /// connection to remote pipes with that info
  /// Will return true if complete success
  Future<Either<LocalDbFailures, Unit>> saveAndActivateRemotePipesDomainToDb({
    required RemotePipesEntity remotePipes,
  });

  /// Save login of different form factors to the local db
  Future<Either<LocalDbFailures, Unit>>
      saveAndActivateVendorLoginCredentialsDomainToDb({
    required LoginEntityAbstract loginEntity,
  });

  /// Get all saved devices
  Future<Map<String, DeviceEntityAbstract>> getAllDevices();

  /// Get all saved rooms
  Future<Map<String, RoomEntity>> getAllRooms();
}
