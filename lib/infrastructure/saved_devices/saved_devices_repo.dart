import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/injection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedDevicesRepo)
class SavedDevicesRepo extends ISavedDevicesRepo {
  SavedDevicesRepo() {
    allDevices = getIt<ILocalDbRepository>().getSmartDevicesFromDb();
  }

  static Map<String, DeviceEntityAbstract> allDevices = {};

  @override
  String addOrUpdateDevice(DeviceEntityAbstract deviceEntity) {
    allDevices[deviceEntity.getDeviceId()] = deviceEntity;

    return 'add or updated success';
  }

  @override
  Future<Map<String, DeviceEntityAbstract>> getAllDevices() async {
    return allDevices;
  }
}
