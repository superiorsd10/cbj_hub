import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:dartz/dartz.dart';

abstract class ISceneCbjRepository {
  Future<List<SceneCbjEntity>> getAllScenesAsList();

  Future<Map<String, SceneCbjEntity>> getAllScenesAsMap();

  /// Sending the new scene to the hub to get added
  Future<Either<SceneCbjFailure, Unit>> addNewScene(
    SceneCbjEntity sceneCbj,
  );

  Future<bool> activateScene(
    SceneCbjEntity sceneCbj,
  );

  /// Get entity and return the full MQTT path to it
  Future<String> getFullMqttPathOfScene(SceneCbjEntity sceneCbj);
}
