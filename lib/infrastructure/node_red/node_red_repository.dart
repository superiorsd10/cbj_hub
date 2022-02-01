import 'package:cbj_hub/domain/node_red/i_node_red_repository.dart';
import 'package:injectable/injectable.dart';

/// Control Node-RED, create scenes and more
@LazySingleton(as: INodeRedRepository)
class NodeRedRepository extends INodeRedRepository {
  /// List of all the scenes JSONs in Node-RED
  List<String> scenesList = [];

  /// List of all the routines JSONs in Node-RED
  List<String> routinesList = [];

  /// List of all the bindings JSONs in Node-RED
  List<String> bindingsList = [];

  @override
  Future<void> createNewScene(String jsonOfScene) {
    // TODO: implement createNewScene
    throw UnimplementedError();
  }

  /// Get entity and return the full MQTT path to it
  Future<String> genericDeviceEntityToMqttPath() async {
    throw 'Not implemented';
  }
}
