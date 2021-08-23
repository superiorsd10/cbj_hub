import 'dart:io';

import 'package:cbj_hub/infrastructure/devices/switcher/switcher_api/switcher_api_object.dart';

class SwitcherDiscover {
  static Stream<SwitcherApiObject> discoverDevices() async* {
    try {
      print('Start Switcher discoverDevices');
      final RawDatagramSocket socket =
          await RawDatagramSocket.bind(InternetAddress.anyIPv4, 20002);

      print('UDP Echo ready to receive');
      print('${socket.address.address}:${socket.port}');
      print('');

      await for (final event in socket) {
        final Datagram? datagram = socket.receive();
        print('Received socket');
        if (datagram == null) return;
        print('datagram not null');
        final SwitcherApiObject switcherApiObject = SwitcherApiObject.fromBytes(
            ipAddress: datagram.address.address, bytes: datagram.data);
        print('Switcher device found ip: ${switcherApiObject.ipAddress}, '
            'type: ${switcherApiObject.deviceType}, '
            'id: ${switcherApiObject.deviceId}, ');
        yield switcherApiObject;
      }
    } catch (e) {
      print('Switcher discover devices got and exception: $e');
    }
  }
}
