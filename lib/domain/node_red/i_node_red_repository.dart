import 'package:cbj_hub/domain/scene/scene_cbj.dart';

/// Class to define all Node RED repo functions
abstract class INodeRedRepository {
  /// Function to create new scene in Node-RED
  Future<void> createNewNodeRedScene(SceneCbj sceneCbj);

  Future<Map<String, SceneCbj>> getAllNodeRedScenes();
}
