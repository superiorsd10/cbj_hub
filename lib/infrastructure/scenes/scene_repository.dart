import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/scene/i_scene_cbj_repository.dart';
import 'package:cbj_hub/domain/scene/scene_cbj.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISceneCbjRepository)
class SceneCbjRepository implements ISceneCbjRepository {
  @override
  Future<Either<SceneCbjFailure, SceneCbj>> getScene() async {
    try {} catch (e) {}
    return left(const SceneCbjFailure.unexpected());
  }

  @override
  Future<Either<SceneCbjFailure, SceneCbj>> addNewScene(
    String sceneName,
    List<MapEntry<DeviceEntityAbstract, MapEntry<String?, String?>>>
        smartDevicesWithActionToAdd,
  ) async {
    return const Left(SceneCbjFailure.unexpected());
  }
}
