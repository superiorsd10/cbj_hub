import 'dart:io';

import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';

class SwitcherDiscover {
  static const SWITCHER_UDP_PORT = 20002;
  static const SWITCHER_UDP_PORT2 = 20003;

  static Stream<SwitcherApiObject> discover20002Devices() async* {
    try {
      final RawDatagramSocket socket20002 = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        SWITCHER_UDP_PORT,
      );

      await for (final event in socket20002) {
        final Datagram? datagram = socket20002.receive();
        if (datagram == null) continue;
        final SwitcherApiObject switcherApiObject =
            SwitcherApiObject.createWithBytes(datagram);

        yield switcherApiObject;
      }
    } catch (e) {
      print('Switcher discover devices got and exception: $e');
    }
  }

  static Stream<SwitcherApiObject> discover20003Devices() async* {
    try {
      final RawDatagramSocket socket20003 = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        SWITCHER_UDP_PORT2,
      );

      await for (final event in socket20003) {
        final Datagram? datagram = socket20003.receive();
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
