import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';

abstract class ISavedDevicesRepo {
  String addOrUpdateFromMqtt(dynamic updateFromMqtt);

  /// Add new device to saved devices list
  String addOrUpdateDevice(DeviceEntityAbstract deviceEntity);

  /// Get all saved devices
  Future<Map<String, DeviceEntityAbstract>> getAllDevices();

  /// Get all saved rooms
  Future<Map<String, RoomEntity>> getAllRooms();
}
