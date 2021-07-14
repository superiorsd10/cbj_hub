import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cbj_hub/infrastructure/gen/aioesphomeapi/protoc_as_dart/aioesphomeapi/api.pbserver.dart';

class AioEspHomeApi {
  ///  Turn smart device on
  static Future<void> helloRequestToEsp(String addressToServer) async {
    // connect to the socket server
    final socket = await Socket.connect(addressToServer, 6053);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

    final HelloRequest helloRequest = HelloRequest(clientInfo: 'aioesphomeapi');

    const int numOfByteBeforeData = 3;

    final List<int> list = utf8.encode(helloRequest.clientInfo);

    final int totalSizeToTransfer = numOfByteBeforeData + list.length;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, list.length);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 1);

//  * The message object encoded as a ProtoBuf message

    for (int i = numOfByteBeforeData;
        i < list.length + numOfByteBeforeData;
        i++) {
      byteData.setUint8(i, list[i - numOfByteBeforeData]);
    }

    print(message);
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
