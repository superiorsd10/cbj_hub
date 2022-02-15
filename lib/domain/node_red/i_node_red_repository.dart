import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';

/// Class to define all Node RED repo functions
abstract class INodeRedRepository {
  /// Function to create new scene in Node-RED
  Future<bool> createNewNodeRedScene(SceneCbjEntity sceneCbj);
}
