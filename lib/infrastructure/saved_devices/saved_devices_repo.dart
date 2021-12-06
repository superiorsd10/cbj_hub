import 'dart:collection';

import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/room/value_objects_room.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedDevicesRepo)
class SavedDevicesRepo extends ISavedDevicesRepo {
  SavedDevicesRepo() {
    allDevices = getIt<ILocalDbRepository>().getSmartDevicesFromDb();
    allRooms = getIt<ILocalDbRepository>().getRoomsFromDb();
  }

  static HashMap<String, DeviceEntityAbstract> allDevices =
      HashMap<String, DeviceEntityAbstract>();

  static HashMap<String, RoomEntity> allRooms = HashMap<String, RoomEntity>();

  @override
  String addOrUpdateFromMqtt(dynamic updateFromMqtt) {
    if(updateFromMqtt is DeviceEntityAbstract){
      return addOrUpdateDevice(updateFromMqtt);
    } else {
      logger.w('Add or update type from MQTT not supported');
    }
    return 'Fail';
  }


  @override
  String addOrUpdateDevice(DeviceEntityAbstract deviceEntity) {
    final String entityId = deviceEntity.getDeviceId();
    if (allDevices[entityId] != null) {
      allDevices[entityId] = deviceEntity;
    } else {
      /// If it is new device
      allDevices[entityId] = deviceEntity;

      final String discoveredRoomId =
          RoomUniqueId.discoveredRoomId().getOrCrash();
      allRooms[discoveredRoomId]!
          .addDeviceId(deviceEntity.uniqueId.getOrCrash()!);

      ConnectorStreamToMqtt.toMqttController.sink.add(
        MapEntry<String, DeviceEntityAbstract>(
          entityId,
          allDevices[entityId]!,
        ),
      );
      ConnectorStreamToMqtt.toMqttController.sink.add(
        MapEntry<String, RoomEntity> (
          discoveredRoomId,
          allRooms[discoveredRoomId]!,
        ),
      );
    }

    return 'add or updated success';
  }

  @override
  Future<Map<String, DeviceEntityAbstract>> getAllDevices() async {
    return allDevices;
  }

  @override
  Future<Map<String, RoomEntity>> getAllRooms() async {
    return allRooms;
  }
}
