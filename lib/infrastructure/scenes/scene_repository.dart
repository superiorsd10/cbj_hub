import 'package:cbj_hub/domain/rooms/i_saved_rooms_repo.dart';
import 'package:cbj_hub/domain/scene/i_scene_cbj_repository.dart';
import 'package:cbj_hub/domain/scene/scene_cbj.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISceneCbjRepository)
class SceneCbjRepository implements ISceneCbjRepository {
  Map<String, SceneCbj> scnesList = {};

  @override
  Future<List<SceneCbj>> getAllScenesAsList() async {
    return scnesList.values.toList();
  }

  @override
  Future<Map<String, SceneCbj>> getAllScenesAsMap() async {
    return scnesList;
  }

  @override
  Future<Either<SceneCbjFailure, Unit>> addNewScene(
    SceneCbj sceneCbj,
  ) async {
    if (!scnesList.keys.contains(sceneCbj.uniqueId.getOrCrash())) {
      scnesList
          .addEntries([MapEntry(sceneCbj.uniqueId.getOrCrash(), sceneCbj)]);
      getIt<ISavedRoomsRepo>().addSceneToRoomDiscoveredIfNotExist(sceneCbj);
    }
    return right(unit);
  }
}
