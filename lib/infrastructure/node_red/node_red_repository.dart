import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/node_red/i_node_red_repository.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_api/node_red_api.dart';
import 'package:cbj_hub/utils.dart';
import 'package:http/src/response.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Control Node-RED, create scenes and more
@LazySingleton(as: INodeRedRepository)
class NodeRedRepository extends INodeRedRepository {
  NodeRedRepository() {
    _deviceIsReadyToSendInternetRequests = isThereInternetConnection();
  }

  /// Set _deviceIsReadyToSendInternetRequests to true when there is an internet
  Future<bool> isThereInternetConnection() async {
    while (true) {
      final bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        break;
      } else {
        logger.w(
          'Node-Red will not get connected until device is connected to www',
        );
      }
      await Future.delayed(const Duration(milliseconds: 300));
    }
    return true;
  }

  /// Here to fix a bug where device crash if trying to send network requests
  /// before there is network.
  /// TODO: check if this can be removed in case we used 127.0.0.1 instead of
  /// localhost and not get this issue again
  /// https://github.com/CyBear-Jinni/cbj_hub/issues/150
  late Future<bool> _deviceIsReadyToSendInternetRequests;

  static NodeRedAPI nodeRedAPI = NodeRedAPI();

  /// List of all the scenes JSONs in Node-RED
  List<String> scenesList = [];

  /// List of all the routines JSONs in Node-RED
  List<String> routinesList = [];

  /// List of all the bindings JSONs in Node-RED
  List<String> bindingsList = [];

  @override
  Future<bool> createNewNodeRedScene(SceneCbjEntity sceneCbj) async {
    await _deviceIsReadyToSendInternetRequests;
    try {
      // TODO: Check if sceneCbj unique Id exist, if so don't try to add it again
      final Response response = await nodeRedAPI.postFlow(
        label: sceneCbj.name.getOrCrash(),
        nodes: sceneCbj.automationString.getOrCrash()!,
      );
      if (response.statusCode == 200) {
        return true;
      }
      logger.i('Response\n${response.statusCode}');
    } catch (e) {
      if (e.toString() ==
          'The remote computer refused the network connection.\r\n') {
        logger.e('Node-RED is not installed');
      } else {
        logger.e('Node-RED create new scene error:\n$e');
      }
    }
    return false;
  }

  @override
  Future<bool> createNewNodeRedRoutine(RoutineCbjEntity routineCbj) async {
    await _deviceIsReadyToSendInternetRequests;

    try {
      // TODO: Check if routineCbj unique Id exist, if so don't try to add it again
      final Response response = await nodeRedAPI.postFlow(
        label: routineCbj.name.getOrCrash(),
        nodes: routineCbj.automationString.getOrCrash()!,
      );
      if (response.statusCode == 200) {
        return true;
      }
      logger.i('Response\n${response.statusCode}');
    } catch (e) {
      if (e.toString() ==
          'The remote computer refused the network connection.\r\n') {
        logger.e('Node-RED is not installed');
      } else {
        logger.e('Node-RED create new routine error:\n$e');
      }
    }
    return false;
  }

  @override
  Future<bool> createNewNodeRedBinding(BindingCbjEntity bindingCbj) async {
    await _deviceIsReadyToSendInternetRequests;
    try {
      // TODO: Check if routineCbj unique Id exist, if so don't try to add it again
      final Response response = await nodeRedAPI.postFlow(
        label: bindingCbj.name.getOrCrash(),
        nodes: bindingCbj.automationString.getOrCrash()!,
      );
      if (response.statusCode == 200) {
        return true;
      }
      logger.i('Response\n${response.statusCode}');
    } catch (e) {
      if (e.toString() ==
          'The remote computer refused the network connection.\r\n') {
        logger.e('Node-RED is not installed');
      } else {
        logger.e('Node-RED create new Binding error:\n$e');
      }
    }
    return false;
  }
}
