import 'dart:collection';

import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/injection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedDevicesRepo)
class SavedDevicesRepo extends ISavedDevicesRepo {
  SavedDevicesRepo() {
    allDevices = getIt<ILocalDbRepository>().getSmartDevicesFromDb();
    allRooms = getIt<ILocalDbRepository>().getRoomsFromDb();
  }

  static HashMap<String, DeviceEntityAbstract> allDevices =
      HashMap<String, DeviceEntityAbstract>();

  static HashMap<String, RoomEntity> allRooms =
      HashMap<String, RoomEntity>();

  @override
  String addOrUpdateDevice(DeviceEntityAbstract deviceEntity) {
    if (allDevices[deviceEntity.getDeviceId()] != null) {
      allDevices[deviceEntity.getDeviceId()] = deviceEntity;
    } else { /// If it is new device
      allDevices[deviceEntity.getDeviceId()] = deviceEntity;

      ConnectorStreamToMqtt.toMqttController.sink.add(
        MapEntry<String, DeviceEntityAbstract>(
          deviceEntity.getDeviceId(),
          allDevices[deviceEntity.getDeviceId()]!,
        ),
      );
    }

    return 'add or updated success';
  }

  @override
  Future<Map<String, DeviceEntityAbstract>> getAllDevices() async {
    return allDevices;
  }
}
