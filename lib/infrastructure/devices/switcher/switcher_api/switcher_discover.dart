import 'dart:io';

import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';

class SwitcherDiscover {
  static Stream<SwitcherApiObject> discoverDevices() async* {
    try {
      final RawDatagramSocket socket =
          await RawDatagramSocket.bind(InternetAddress.anyIPv4, 20002);

      await for (final event in socket) {
        final Datagram? datagram = socket.receive();
        if (datagram == null) continue;
        final SwitcherApiObject switcherApiObject =
            SwitcherApiObject.createWithBytes(datagram);

        yield switcherApiObject;
      }
    } catch (e) {
      print('Switcher discover devices got and exception: $e');
    }
  }
}
