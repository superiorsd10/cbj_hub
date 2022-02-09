import 'package:cbj_hub/domain/node_red/i_node_red_repository.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_api/node_red_api.dart';
import 'package:cbj_hub/utils.dart';
import 'package:http/src/response.dart';
import 'package:injectable/injectable.dart';

/// Control Node-RED, create scenes and more
@LazySingleton(as: INodeRedRepository)
class NodeRedRepository extends INodeRedRepository {
  static NodeRedAPI nodeRedAPI = NodeRedAPI();

  /// List of all the scenes JSONs in Node-RED
  List<String> scenesList = [];

  /// List of all the routines JSONs in Node-RED
  List<String> routinesList = [];

  /// List of all the bindings JSONs in Node-RED
  List<String> bindingsList = [];

  @override
  Future<void> createNewScene(String label, String jsonOfNodes) async {
    final Response response =
        await nodeRedAPI.postFlow(label: 'test', nodes: jsonOfNodes);
    logger.i('Response\n${response.statusCode}');
  }

  /// Get entity and return the full MQTT path to it
  Future<String> genericDeviceEntityToMqttPath() async {
    throw 'Not implemented';
  }
}
