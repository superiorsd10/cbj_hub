import 'package:cbj_hub/utils.dart';
import 'package:http/http.dart';

/// Admin API methods for Node-RED
/// https://nodered.org/docs/api/admin/methods/
class NodeRedAPI {
  /// Creates the request url for Nod-RED, use default connection values
  /// if not specified otherwise
  NodeRedAPI({
    this.address = 'localhost',
    this.port = 1880,
  }) {
    requestsUrl = 'http://$address:$port';
  }

  /// The address of Node-RED to connect to
  String address;

  /// The port to connect to of Node-RED
  int port;

  /// Requests url to Node-RED, contains the address followed up with the port
  late String requestsUrl;

  /// Get the active authentication scheme
  Future<Response> getAuthLogin() async {
    return get(Uri.parse('$requestsUrl/auth/login'));
  }

  /// Exchange credentials for access token
  Future<Response> postAuthToken({
    String clientId = 'node-red-editor',
    required String grantType,
    required String scope,
    required String userName,
    required String password,
  }) async {
    logger.e('Not tested yet');
    final String jsonStringWithFields = '''
    {
      "client_id": "$clientId",
      "grant_type": "$grantType",
      "scope": "$scope",    
      "username": "$userName",    
      "password": "$password"    
    }
    ''';
    return post(
      Uri.parse('$requestsUrl/auth/token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Revoke an access token
  Future<Response> postAuthRevoke(String token) async {
    logger.e('Not tested yet');
    return post(
      Uri.parse('$requestsUrl/auth/revoke'),
      headers: {'Content-Type': 'application/json'},
      body: token,
    );
  }

  /// Get the runtime settings
  Future<Response> getSettings() async {
    return get(Uri.parse('$requestsUrl/settings'));
  }

  /// Get the active flow configuration
  Future<Response> getFlows() async {
    return get(Uri.parse('$requestsUrl/flows'));
  }

  /// Set the active flow configuration.
  Future<Response> postFlows({
    int vType = 1,
    String? rev,
    required String type,
    required String id,
    required String label,
  }) async {
    logger.e('Not tested yet');

    final String jsonStringWithFields;

    if (vType == 1) {
      jsonStringWithFields = '''
      [
        {
          "type": "$type",
          "id": "$id",
          "label": "$label"
        }
      ]
      ''';
    } else if (vType == 2 && rev != null) {
      jsonStringWithFields = '''
      {
        "rev": "$rev",
        "flows": [
          {
            "type": "$type",
            "id": "$id",
            "label": "$label"
          }
        ]
      }
      ''';
    } else {
      logger.e('vType is invalid or rev is missing $rev');
      throw 'Error vType is invalid or rev is missing $rev';
    }
    return post(
      Uri.parse('$requestsUrl/flows'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Add a flow to the active configuration
  Future<Response> postFlow({
    required String id,
    required String label,
    required List<dynamic> nodes,
    required List<dynamic> configs,
  }) async {
    logger.e('Not tested yet');
    final String jsonStringWithFields = '''
      {
        "id": "$id",
        "label": "$label"
        "nodes": $nodes,
        "configs": $configs
      }
      ''';
    return post(
      Uri.parse('$requestsUrl/flows'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Get an individual flow configuration
  Future<Response> getFlowById(String flowId) async {
    return get(Uri.parse('$requestsUrl/flow/$flowId'));
  }

  /// Update an individual flow configuration
  Future<Response> putFlowById({
    bool normalFlow = true,
    required String id,
    required List<dynamic> configs,
    required List<dynamic> nodes,
    String? label,
    List<dynamic>? subFlows,
  }) async {
    logger.e('Not tested yet');
    final String jsonStringWithFields;

    if (normalFlow) {
      jsonStringWithFields = '''
        {
          "id": "$id",
          "label": "$label",
          "nodes": $nodes,
          "configs": $configs,
        }
        ''';
    } else {
      jsonStringWithFields = '''
        {
          "id": "$id",
          "configs": $configs,
          "subflows": $subFlows,
        }
        ''';
    }

    return put(
      Uri.parse('$requestsUrl/flow/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Delete an individual flow configuration
  Future<Response> deleteFlowById({
    required String id,
  }) async {
    logger.e('Not tested yet');
    return delete(
      Uri.parse('$requestsUrl/flow/$id'),
    );
  }

  /// Get a list of the installed nodes
  Future<Response> getNodes() async {
    return get(Uri.parse('$requestsUrl/nodes'));
  }

  /// Install a new node module
  Future<Response> postNodes({
    required String module,
  }) async {
    logger.e('Not tested yet');
    final String jsonStringWithFields = '''
    {
      "module": "$module",
    }
    ''';
    return post(
      Uri.parse('$requestsUrl/nodes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Get a node module’s information
  Future<Response> getNodesByModule(String moduleId) async {
    return get(Uri.parse('$requestsUrl/nodes/$moduleId'));
  }

  /// Enable/Disable a node module
  Future<Response> putNodesByModule({
    required String module,
    required bool enableTheModule,
  }) async {
    logger.e('Not tested yet');
    final String jsonStringWithFields = '''
        {
          "enabled": $enableTheModule
        }
        ''';

    return put(
      Uri.parse('$requestsUrl/nodes/$module'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }

  /// Remove a node module
  Future<Response> deleteNodesByModule({
    required String module,
  }) async {
    logger.e('Not tested yet');
    return delete(
      Uri.parse('$requestsUrl/nodes/$module'),
    );
  }

  /// Get a node module set information
  Future<Response> getNodesByModelSetInformation(
    String moduleId,
    String set,
  ) async {
    return get(Uri.parse('$requestsUrl/nodes/$moduleId/$set'));
  }

  /// Enable/Disable a node set
  Future<Response> putNodesModuleSetInformation({
    required String module,
    required String setName,
    required String enableTheModule,
  }) async {
    logger.e('Not tested yet');
    final String jsonStringWithFields = '''
        {
          "enabled": $enableTheModule
        }
        ''';

    return put(
      Uri.parse('$requestsUrl/nodes/$module/$setName'),
      headers: {'Content-Type': 'application/json'},
      body: jsonStringWithFields,
    );
  }
}
