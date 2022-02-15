import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/node_red/i_node_red_repository.dart';
import 'package:cbj_hub/domain/rooms/i_saved_rooms_repo.dart';
import 'package:cbj_hub/domain/scene/i_scene_cbj_repository.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISceneCbjRepository)
class SceneCbjRepository implements ISceneCbjRepository {
  Map<String, SceneCbjEntity> scnesList = {};

  @override
  Future<List<SceneCbjEntity>> getAllScenesAsList() async {
    return scnesList.values.toList();
  }

  @override
  Future<Map<String, SceneCbjEntity>> getAllScenesAsMap() async {
    return scnesList;
  }

  @override
  Future<Either<SceneCbjFailure, Unit>> addNewScene(
    SceneCbjEntity sceneCbj,
  ) async {
    if (!scnesList.keys.contains(sceneCbj.uniqueId.getOrCrash())) {
      scnesList
          .addEntries([MapEntry(sceneCbj.uniqueId.getOrCrash(), sceneCbj)]);
      getIt<ISavedRoomsRepo>().addSceneToRoomDiscoveredIfNotExist(sceneCbj);
      getIt<INodeRedRepository>().createNewNodeRedScene(sceneCbj);
    }
    return right(unit);
  }

  @override
  Future<bool> activateScene(SceneCbjEntity sceneCbj) async {
    final String fullPathOfScene = await getFullMqttPathOfScene(sceneCbj);
    getIt<IMqttServerRepository>()
        .publishMessage(fullPathOfScene, DateTime.now().toString());

    return true;
  }

  /// Get entity and return the full MQTT path to it
  @override
  Future<String> getFullMqttPathOfScene(SceneCbjEntity sceneCbj) async {
    final String hubBaseTopic =
        getIt<IMqttServerRepository>().getHubBaseTopic();
    final String scenesTopicTypeName =
        getIt<IMqttServerRepository>().getScenesTopicTypeName();
    final String sceneId = sceneCbj.firstNodeId.getOrCrash()!;

    return '$hubBaseTopic/$scenesTopicTypeName/$sceneId';
  }
}
