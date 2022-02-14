import 'package:cbj_hub/domain/scene/scene_cbj.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:dartz/dartz.dart';

abstract class ISceneCbjRepository {
  Future<List<SceneCbj>> getAllScenesAsList();

  Future<Map<String, SceneCbj>> getAllScenesAsMap();

  /// Sending the new scene to the hub to get added
  Future<Either<SceneCbjFailure, Unit>> addNewScene(
    SceneCbj sceneCbj,
  );
}
