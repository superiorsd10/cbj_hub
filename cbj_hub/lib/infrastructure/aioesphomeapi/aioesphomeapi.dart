import 'dart:io';
import 'dart:typed_data';

class AioEspHomeApi {
  ///  Turn smart device on
  static Future<void> createStreamWithHub(String addressToServer) async {
    // connect to the socket server
    final socket = await Socket.connect(addressToServer, 6053);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

    final message = Uint8List(8);
    final bytedata = ByteData.view(message.buffer);

    bytedata.setUint8(0, 0x00);
    bytedata.setUint8(1, 0x07);
    bytedata.setUint8(2, 0xFF);
    bytedata.setUint8(3, 0x88);
    bytedata.setUint8(4, 0x88);
    bytedata.setUint8(5, 0x88);
    bytedata.setUint8(6, 0x88);
    bytedata.setUint8(7, 0x88);

    socket.add(message);

    // listen for responses from the server
    socket.listen(
      // handle data from the server
      (Uint8List data) {
        final serverResponse = String.fromCharCodes(data);
        print('Server: $serverResponse');
      },

      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
  }

  static Future<void> sendMessage(Socket socket, String message) async {
    print('Client: $message');
    socket.write(message);

    await Future.delayed(const Duration(seconds: 2));
  }
}
