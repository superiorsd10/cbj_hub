import 'dart:convert';

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
import 'package:cbj_hub/infrastructure/room/saved_rooms_repo.dart';
import 'package:cbj_hub/infrastructure/scenes/area_types_scientific_presets/area_type_with_device_type_preset.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
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
  Future<Either<LocalDbFailures, Unit>> saveAndActivateScenesToDb() {
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

      await saveAndActivateScenesToDb();
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

  @override
  Future<Either<SceneCbjFailure, Unit>>
      addDevicesToMultipleScenesAreaTypeWithPreSetActions({
    required List<String> devicesId,
    required List<String> scenesId,
    required List<String> areaTypes,
  }) async {
    final List<MapEntry<String, AreaPurposesTypes>> areaTypeWithSceneIdList =
        [];

    for (final String sceneId in scenesId) {
      if (_allScenes[sceneId] == null) {
        logger.w('Scene ID does not exist in saved scenes list\n $sceneId');
        continue;
      }
      final SceneCbjEntity sceneCbjEntity = _allScenes[sceneId]!;

      final AreaPurposesTypes? areaTypeForScene =
          SavedRoomsRepo.getAreaTypeFromNameCapsWithSpcaes(
        sceneCbjEntity.name.getOrCrash(),
      );

      if (areaTypeForScene != null) {
        areaTypeWithSceneIdList.add(MapEntry(sceneId, areaTypeForScene));
      }
    }

    for (final MapEntry<String, AreaPurposesTypes> areaTypeWithSceneId
        in areaTypeWithSceneIdList) {
      addDevicesToSceneAreaTypeWithPreSetActions(
        devicesId: devicesId,
        sceneId: areaTypeWithSceneId.key,
        areaType: areaTypeWithSceneId.value,
      );
    }

    return right(unit);
  }

  @override
  Future<Either<SceneCbjFailure, SceneCbjEntity>>
      addDevicesToSceneAreaTypeWithPreSetActions({
    required List<String> devicesId,
    required String sceneId,
    required AreaPurposesTypes areaType,
  }) async {
    SceneCbjEntity? scene = _allScenes[sceneId];

    if (scene == null || scene.automationString.getOrCrash() == null) {
      return left(const SceneCbjFailure.unexpected());
    }

    final String sceneAutomationString = scene.automationString.getOrCrash()!;
    late String brokerNodeId;
    try {
      final String? tempValue = getPropertyValueFromAutomation(
        sceneAutomationString,
        'mqtt-broker',
        'id',
      );
      if (tempValue == null) {
        return left(const SceneCbjFailure.unexpected());
      }
      brokerNodeId = tempValue;
    } catch (e) {
      logger.e('Error decoding automation string\n$sceneAutomationString');
    }
    final Map<String, String> nodeActionsMap = {};

    for (final String deviceId in devicesId) {
      if (!scene.automationString.getOrCrash()!.contains(deviceId)) {
        final Either<SceneCbjFailure, Map<String, String>>
            actionForDevicesInArea = await AreaTypeWithDeviceTypePreset
                .getPreDefineActionForDeviceInArea(
          deviceId: deviceId,
          areaPurposeType: areaType,
          brokerNodeId: brokerNodeId,
        );
        if (actionForDevicesInArea.isRight()) {
          actionForDevicesInArea.fold(
            (l) => null,
            (r) {
              nodeActionsMap.addAll(r);
            },
          );
        }
      }
    }

    // Removing start and end curly braces of the map object
    final String mapAutomationFixed = nodeActionsMap.values
        .toString()
        .substring(1, nodeActionsMap.values.toString().length - 1);
    String tempNewAutomation;
    if (mapAutomationFixed.isEmpty) {
      tempNewAutomation = '[ ${sceneAutomationString.substring(1)}';
    } else {
      tempNewAutomation =
          '[ $mapAutomationFixed, ${sceneAutomationString.substring(1)}';
    }
    scene = scene.copyWith(
      automationString: SceneCbjAutomationString(tempNewAutomation),
    );
    _allScenes[sceneId] = scene;

    saveAndActivateScenesToDb();
    await getIt<INodeRedRepository>().createNewNodeRedScene(scene);

    //TODO: add to the automationString part the new automation for devices String from actionForDevicesInArea and connect all to first node id
    return right(scene);
  }

  static String? getPropertyValueFromAutomation(
    String sceneAutomationString,
    String nodeType,
    String keyToGetFromNode,
  ) {
    try {
      String brokerNodeId;
      final List<Map<String, dynamic>> sceneAutomationJson =
          (jsonDecode(sceneAutomationString) as List)
              .map((e) => e as Map<String, dynamic>)
              .toList();
      for (final Map<String, dynamic> fullNode in sceneAutomationJson) {
        if (fullNode['type'] == nodeType) {
          return fullNode[keyToGetFromNode].toString();
        }
      }
    } catch (e) {
      logger.e('Error decoding automation string\n$sceneAutomationString');
    }
    return null;
  }
}
