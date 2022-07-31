import 'dart:io';

import 'package:cbj_hub/infrastructure/devices/shelly/shelly_api/shelly_device_abstract.dart';

class ShellyColorBulb extends ShellyDeviceAbstract {
  ShellyColorBulb({
    required super.lastKnownIp,
    required super.mDnsName,
    required super.hostName,
  });

  Future<String> turnOn() async {
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/color/0?turn=on'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }

  Future<String> turnOff() async {
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/color/0?turn=off'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }
}
