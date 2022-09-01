import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/scenes/area_types_scientific_presets/common_devices_scenes_presets_for_devices.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';

/// Pre define actions for each device in each area
class AreaTypeWithDeviceTypePreset {
  static Future<Either<SceneCbjFailure, Map<String, String>>>
      getPreDefineActionForDeviceInArea({
    required String deviceId,
    required AreaPurposesTypes areaPurposeType,
    required String brokerNodeId,
  }) async {
    final Either<LocalDbFailures, DeviceEntityAbstract> dTemp =
        await getIt<ISavedDevicesRepo>().getDeviceById(deviceId);
    if (dTemp.isLeft()) {
      return left(const SceneCbjFailure.unexpected());
    }
    late DeviceEntityAbstract deviceEntity;

    dTemp.fold((l) => null, (r) {
      deviceEntity = r;
    });

    switch (areaPurposeType) {
      case AreaPurposesTypes.attic:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.bathtub:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.bedroom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.boardGames:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.childrensRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.cinemaRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.diningRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.holidayCabin:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.kitchen:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.laundryRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.livingRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.meditation:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.outside:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.outsideNotPrimary:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.outsidePrimary:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.protectedSpace:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.romantic:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.safeRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.shower:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.stairsInside:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.stairsOutside:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.studyRoom:
        return studyRoomDeviceAction(deviceEntity, brokerNodeId);
      case AreaPurposesTypes.toiletRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.trainingRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.tvRoom:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.videoGames:
        // TODO: Handle this case.
        break;
      case AreaPurposesTypes.workRoom:
        // TODO: Handle this case.
        break;
    }
    return left(const SceneCbjFailure.unexpected());
  }

  static Future<Either<SceneCbjFailure, Map<String, String>>>
      studyRoomDeviceAction(
    DeviceEntityAbstract deviceEntity,
    String brokerNodeId,
  ) async {
    final DeviceTypes deviceType = DeviceTypes.values.firstWhere(
      (element) => element.name == deviceEntity.deviceTypes.getOrCrash(),
    );

    switch (deviceType) {
      case DeviceTypes.AirConditioner:
        // TODO: Handle this case.
        break;
      case DeviceTypes.babyMonitor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.bed:
        // TODO: Handle this case.
        break;
      case DeviceTypes.blinds:
        // TODO: Handle this case.
        break;
      case DeviceTypes.boiler:
        // TODO: Handle this case.
        break;
      case DeviceTypes.browserApp:
        // TODO: Handle this case.
        break;
      case DeviceTypes.button:
        // TODO: Handle this case.
        break;
      case DeviceTypes.buttonWithLight:
        // TODO: Handle this case.
        break;
      case DeviceTypes.cctLight:
        // TODO: Handle this case.
        break;
      case DeviceTypes.coffeeMachine:
        // TODO: Handle this case.
        break;
      case DeviceTypes.computerApp:
        // TODO: Handle this case.
        break;
      case DeviceTypes.dimmableLight:
        // TODO: Handle this case.
        break;
      case DeviceTypes.dishwasher:
        // TODO: Handle this case.
        break;
      case DeviceTypes.hub:
        // TODO: Handle this case.
        break;
      case DeviceTypes.humiditySensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.kettle:
        // TODO: Handle this case.
        break;
      case DeviceTypes.light:
        // TODO: Handle this case.
        break;
      case DeviceTypes.lightSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.microphone:
        // TODO: Handle this case.
        break;
      case DeviceTypes.motionSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.oven:
        // TODO: Handle this case.
        break;
      case DeviceTypes.oxygenSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.phoneApp:
        // TODO: Handle this case.
        break;
      case DeviceTypes.printer:
        // TODO: Handle this case.
        break;
      case DeviceTypes.printerWithScanner:
        // TODO: Handle this case.
        break;
      case DeviceTypes.refrigerator:
        // TODO: Handle this case.
        break;
      case DeviceTypes.rgbLights:
        // TODO: Handle this case.
        break;
      case DeviceTypes.rgbcctLights:
        // TODO: Handle this case.
        break;
      case DeviceTypes.rgbwLights:
        final Map<String, String> actionsList = {};
        actionsList.addEntries([
          CommonDevicesScenesPresetsForDevices.rgbLightOnPreset(
            deviceEntity,
            brokerNodeId,
          ),
        ]);
        // TODO: add light color change to blue

        return right(actionsList);
        break;
      case DeviceTypes.scanner:
        // TODO: Handle this case.
        break;
      case DeviceTypes.securityCamera:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartPlug:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartSpeakers:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartTV:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartWatch:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smartWaterBottle:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smokeDetector:
        // TODO: Handle this case.
        break;
      case DeviceTypes.smokeSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.soundSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.switch_:
        // TODO: Handle this case.
        break;
      case DeviceTypes.teapot:
        // TODO: Handle this case.
        break;
      case DeviceTypes.temperatureSensor:
        // TODO: Handle this case.
        break;
      case DeviceTypes.toaster:
        // TODO: Handle this case.
        break;
      case DeviceTypes.typeNotSupported:
        // TODO: Handle this case.
        break;
      case DeviceTypes.vacuumCleaner:
        // TODO: Handle this case.
        break;
      case DeviceTypes.washingMachine:
        // TODO: Handle this case.
        break;
    }
    return right(<String, String>{});
  }
}
