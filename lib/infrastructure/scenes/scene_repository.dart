import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/domain/node_red/i_node_red_repository.dart';
import 'package:cbj_hub/domain/rooms/i_saved_rooms_repo.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/scene/i_scene_cbj_repository.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_failures.dart';
import 'package:cbj_hub/domain/scene/value_objects_scene_cbj.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_converter.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: ISceneCbjRepository)
class SceneCbjRepository implements ISceneCbjRepository {
  SceneCbjRepository() {
    setUpAllFromDb();
  }
  final Map<String, SceneCbjEntity> _allScenes = {};

  Future<void> setUpAllFromDb() async {
    /// Delay inorder for the Hive boxes to initialize
    /// In case you got the following error:
    /// "HiveError: You need to initialize Hive or provide a path to store
    /// the box."
    /// Please increase the duration
    await Future.delayed(const Duration(milliseconds: 100));

    getIt<ILocalDbRepository>().getScenesFromDb().then((value) {
      value.fold((l) => null, (r) {
        r.forEach((element) {
          addNewScene(element);
        });
      });
    });
  }

  @override
  Future<List<SceneCbjEntity>> getAllScenesAsList() async {
    return _allScenes.values.toList();
  }

  @override
  Future<Map<String, SceneCbjEntity>> getAllScenesAsMap() async {
    return _allScenes;
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveAndActivateSceneToDb() {
    return getIt<ILocalDbRepository>().saveScenes(
      sceneList: List<SceneCbjEntity>.from(_allScenes.values),
    );
  }

  @override
  Future<Either<SceneCbjFailure, Unit>> addNewScene(
    SceneCbjEntity sceneCbj,
  ) async {
    /// Check if scene already exist
    if (findSceneIfAlreadyBeenAdded(sceneCbj) == null) {
      _allScenes
          .addEntries([MapEntry(sceneCbj.uniqueId.getOrCrash(), sceneCbj)]);

      final String entityId = sceneCbj.uniqueId.getOrCrash();

      /// If it is new scene
      _allScenes[entityId] = sceneCbj;

      await saveAndActivateSceneToDb();
      await getIt<ISavedDevicesRepo>().saveAndActivateSmartDevicesToDb();
      getIt<ISavedRoomsRepo>().addSceneToRoomDiscoveredIfNotExist(sceneCbj);
      await getIt<INodeRedRepository>().createNewNodeRedScene(sceneCbj);
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

  /// Check if all scenes does not contain the same scene already
  /// Will compare the unique id's that each company sent us
  SceneCbjEntity? findSceneIfAlreadyBeenAdded(
    SceneCbjEntity sceneEntity,
  ) {
    return _allScenes[sceneEntity.uniqueId.getOrCrash()];
  }

  @override
  Future<Either<SceneCbjFailure, SceneCbjEntity>> addOrUpdateNewSceneInHub(
    SceneCbjEntity sceneCbjEntity,
  ) async {
    addNewScene(sceneCbjEntity);

    return right(sceneCbjEntity);
  }

  @override
  Future<Either<SceneCbjFailure, SceneCbjEntity>>
      addOrUpdateNewSceneInHubFromDevicesPropertyActionList(
    String sceneName,
    List<MapEntry<DeviceEntityAbstract, MapEntry<String?, String?>>>
        smartDevicesWithActionToAdd,
  ) async {
    final SceneCbjEntity newCbjScene = NodeRedConverter.convertToSceneNodes(
      nodeName: sceneName,
      devicesPropertyAction: smartDevicesWithActionToAdd,
    );
    return addOrUpdateNewSceneInHub(newCbjScene);
  }

  @override
  Future<Either<SceneCbjFailure, Unit>> activateScenes(
    KtList<SceneCbjEntity> scenesList,
  ) async {
    for (final SceneCbjEntity sceneCbjEntity in scenesList.asList()) {
      addOrUpdateNewSceneInHub(
        sceneCbjEntity.copyWith(
          deviceStateGRPC: SceneCbjDeviceStateGRPC(
            DeviceStateGRPC.waitingInFirebase.toString(),
          ),
        ),
      );
    }
    return right(unit);
  }

  @override
  void addOrUpdateNewSceneInApp(SceneCbjEntity sceneCbj) {
    _allScenes[sceneCbj.uniqueId.getOrCrash()] = sceneCbj;

    scenesResponseFromTheHubStreamController.sink
        .add(_allScenes.values.toImmutableList());
  }

  @override
  Future<void> initiateHubConnection() async {}

  @override
  Stream<Either<SceneCbjFailure, KtList<SceneCbjEntity>>>
      watchAllScenes() async* {
    yield* scenesResponseFromTheHubStreamController.stream
        .map((event) => right(event));
  }

  @override
  BehaviorSubject<KtList<SceneCbjEntity>>
      scenesResponseFromTheHubStreamController =
      BehaviorSubject<KtList<SceneCbjEntity>>();
}
