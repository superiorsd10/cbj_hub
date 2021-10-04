import 'dart:convert';

import 'package:http/http.dart';

import 'tuya_device_abstract.dart';

/// Tuya integration with cloud API
class CloudTuya {
  CloudTuya({
    required this.userName,
    required this.userPassword,
    required this.countryCode,
    required this.bizType,
    required this.region,
  }) {
    uri = 'https://px1.tuya$region.com/homeassistant';
  }

  /// Email of the user
  String userName;

  /// Password of the user
  String userPassword;

  /// Country code (International dialing number) sometimes can be called
  /// "Country Calling Code" without the +.
  /// You can yours from here https://www.countrycode.org
  String countryCode;

  /// App business can be: tuya, smart_life, jinvoo_smart
  String bizType;

  /// Region of the user, can be cn, eu, us
  String region;

  /// You likely don't need to touch this
  String from = 'tuna';

  /// Ru
  late String uri;

  String? tokens;

  Future<void> login() async {
    Uri uriTemp = Uri.parse('$uri/auth.do');
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    Map<String, dynamic> body = {
      'bizType': bizType,
      'countryCode': countryCode,
      'from': from,
      'password': userPassword,
      'userName': userName,
    };

    Response response =
        await consistentRequest(uriTemp, headers: headers, body: body);

    int statusCode = response.statusCode;
    String responseBody = response.body;

    if (responseBody.contains('error')) {
      print('Error: $responseBody');
      print('Will try again in 60s');
      await Future.delayed(Duration(seconds: 60));
      return await login();
    }
    String accessToken =
        responseBody.substring(responseBody.indexOf('access_token') + 15);
    tokens = accessToken.substring(0, accessToken.indexOf('"'));
  }

  /// Find all devices associated to the login user
  Future<List<TuyaDeviceAbstract>> findDevices() async {
    if (tokens == null) {
      await login();
    }
    Uri uriTemp = Uri.parse('$uri/skill');

    Map<String, String> headers = {'Content-Type': 'application/json'};

    String data = json.encode({
      'header': {
        'name': 'Discovery',
        'namespace': 'discovery',
        'payloadVersion': '1',
      },
      'payload': {
        'accessToken': tokens,
      },
    });

    Response response =
        await consistentRequest(uriTemp, headers: headers, body: data);

    int statusCode = response.statusCode;
    String responseBody = response.body;

    dynamic a = json.decode(responseBody);
    dynamic devicesList = a['payload']['devices'];
    print('Devices:\n$devicesList');
    List<TuyaDeviceAbstract> tuyaDeviceList = [];
    for (dynamic device in devicesList) {
      if (device['ha_type'] != 'scene') {
        TuyaDeviceAbstract tuyaDevice =
            TuyaDeviceAbstract.fromInternalLinkedHashMap(device);
        print('Device $tuyaDevice');
        tuyaDeviceList.add(tuyaDevice);
      }
    }

    return tuyaDeviceList;
  }

  /// Find all scenes associated to the login user
  Future<dynamic> findScenes() async {
    if (tokens == null) {
      await login();
    }
    Uri uriTemp = Uri.parse('$uri/skill');

    Map<String, String> headers = {'Content-Type': 'application/json'};

    String data = json.encode({
      'header': {
        'name': 'Discovery',
        'namespace': 'discovery',
        'payloadVersion': '1',
      },
      'payload': {
        'accessToken': tokens,
      },
    });

    Response response =
        await consistentRequest(uriTemp, headers: headers, body: data);

    int statusCode = response.statusCode;
    String responseBody = response.body;

    dynamic a = json.decode(responseBody);
    dynamic scenesList = a['payload']['scenes'];
    print('Scenes:\n$scenesList');

    return scenesList;
  }

  Future<Response> consistentRequest(
    Uri url, {
    required Map<String, String> headers,
    required dynamic body,
    Encoding? encoding,
  }) async {
    Response response = await post(
      url,
      headers: headers,
      body: body,
      // encoding: encoding,
    );

    return response;
  }

  Future<String> setState(String deviceId, String command) async {
    if (tokens == null) {
      await login();
    }
    Uri uriTemp = Uri.parse('$uri/skill');

    Map<String, String> headers = {'Content-Type': 'application/json'};

    String data = json.encode({
      'header': {
        'name': 'turnOnOff',
        'namespace': 'control',
        'payloadVersion': '1',
      },
      'payload': {
        'accessToken': tokens,
        'devId': deviceId,
        'value': command,
      },
    });

    Response response =
        await consistentRequest(uriTemp, headers: headers, body: data);

    int statusCode = response.statusCode;
    String responseBody = response.body;

    dynamic responseDecoded = json.decode(responseBody);

    return responseDecoded['header']['code'] as String;
  }

  Future<String> turnOn(String deviceId) async {
    return setState(deviceId, '1');
  }

  Future<String> turnOff(String deviceId) async {
    return setState(deviceId, '0');
  }
}
