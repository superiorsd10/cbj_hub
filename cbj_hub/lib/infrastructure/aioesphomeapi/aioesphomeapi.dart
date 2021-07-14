import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cbj_hub/infrastructure/gen/aioesphomeapi/protoc_as_dart/aioesphomeapi/api.pbserver.dart';

class AioEspHomeApi {
  AioEspHomeApi(this.fSocket);

  factory AioEspHomeApi.createWithAddress(String addressOfServer) {
    final Future<Socket> socket = Socket.connect(addressOfServer, 6053);

    return AioEspHomeApi(socket);
  }

  Future<Socket> fSocket;

  Future<void> listenToResponses() async {
    final Socket socket = await fSocket;

    socket.listen(
      // handle data from the server
      (Uint8List data) {
        final int responseType = data[2];

        /// ConnectResponse
        if (responseType == 4) {
          print('responseType is ConnectResponse');
          print('ConnectResponse data: ${utf8.decode(data.sublist(3))}');
          print('Data: $data');
          print('');
        }

        /// HelloResponse
        else if (responseType == 2) {
          print('responseType is HelloResponse');
          final HelloResponse? helloResponseData = bytesToHelloResponse(data);
          print('HelloResponse data: ${helloResponseData?.serverInfo}');
          print('');
        }

        /// DeviceInfoResponse
        else if (responseType == 10) {
          print('responseType is DeviceInfoResponse');
          print('DeviceInfoResponse data: ${utf8.decode(data.sublist(3))}');
          print('');
        }

        /// PingResponse
        else if (responseType == 8) {
          print('responseType is PingResponse');
          print('PingResponse data: ${utf8.decode(data.sublist(3))}');
          print('');
        } else {
          print('responseType is else');
          print('Listen to data $data');
          print('');
        }
        // print('Hello data2: ${utf8.decode(data)}');
        // serverResponse = String.fromCharCodes(data);
        // print('Server: $serverResponse');
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

  Future<void> sendConnect(String devicePass) async {
    // connect to the socket server
    final Socket socket = await fSocket;

    final ConnectRequest connectRequest = ConnectRequest(password: devicePass);

    const int numOfByteBeforeData = 3;

    final List<int> list = utf8.encode(connectRequest.password);

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
    byteData.setUint8(2, 3);

    byteData.setUint8(3, 6);

//  * The message object encoded as a ProtoBuf message

    for (int i = numOfByteBeforeData;
        i < list.length + numOfByteBeforeData;
        i++) {
      byteData.setUint8(i, list[i - numOfByteBeforeData]);
    }

    socket.add(message);
  }

  ///  Turn smart device on
  Future<void> helloRequestToEsp() async {
    // connect to the socket server
    final Socket socket = await fSocket;

    final HelloRequest helloRequest = HelloRequest(clientInfo: 'aioesphomeapi');

    const int numOfByteBeforeData = 3;

    final List<int> clientInfoAsIntList = utf8.encode(helloRequest.clientInfo);

    final int totalSizeToTransfer =
        numOfByteBeforeData + clientInfoAsIntList.length;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, clientInfoAsIntList.length);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 1);

//  * The message object encoded as a ProtoBuf message

    for (int i = numOfByteBeforeData;
        i < clientInfoAsIntList.length + numOfByteBeforeData;
        i++) {
      byteData.setUint8(i, clientInfoAsIntList[i - numOfByteBeforeData]);
    }

    socket.add(message);
  }

  ///  Turn smart device on
  Future<void> connectRequestToEsp(
      String addressToServer, String password) async {
    // connect to the socket server
    final socket = await fSocket;

    final ConnectRequest connectRequest = ConnectRequest(password: password);

    final List<int> passwordAsIntList = utf8.encode(connectRequest.password);

    const int numOfBytesBeforeData = 3;

    // final List<int> list = utf8.encode(helloRequest.password);

    final int totalSizeToTransfer =
        numOfBytesBeforeData + passwordAsIntList.length;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, connectRequest.password.length);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 3);

//  * The message object encoded as a ProtoBuf message
//
    for (int i = numOfBytesBeforeData;
        i < connectRequest.password.length + numOfBytesBeforeData;
        i++) {
      byteData.setUint8(i, passwordAsIntList[i - numOfBytesBeforeData]);
    }

    socket.add(message);
  }

  ///  Turn smart device on
  Future<void> ping() async {
    // connect to the socket server
    final socket = await fSocket;
    print('Connected request to: '
        '${socket.remoteAddress.address}:${socket.remotePort}');

    final PingRequest helloRequest = PingRequest();

    const int numOfByteBeforeData = 3;

    const int totalSizeToTransfer = numOfByteBeforeData;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, 0);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 7);

//  * The message object encoded as a ProtoBuf message

    socket.add(message);
  }

  ///  Turn smart device on
  Future<void> deviceInfoRequestToEsp() async {
    // connect to the socket server
    final socket = await fSocket;
    print('Connected request to:'
        ' ${socket.remoteAddress.address}:${socket.remotePort}');

    final DeviceInfoRequest deviceInfoRequest = DeviceInfoRequest();

    const int numOfByteBeforeData = 3;

    // final List<int> list = utf8.encode(helloRequest.toString());

    const int totalSizeToTransfer = numOfByteBeforeData;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// First, a message in this protocol has a specific format:

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, 0);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 9);

//  * The message object encoded as a ProtoBuf message
//
//     for (int i = numOfByteBeforeData;
//         i < list.length + numOfByteBeforeData;
//         i++) {
//       byteData.setUint8(i, list[i - numOfByteBeforeData]);
//     }

    socket.add(message);
  }

  static HelloResponse? bytesToHelloResponse(List<int> bytes) {
    // Check if request is hello response
    if (bytes[2] != 2) {
      return null;
    }

    final HelloResponse helloResponse = HelloResponse();

    final List<int> responseBytes = bytes.sublist(3);
    helloResponse.serverInfo = utf8.decode(responseBytes);
    for (final int b in responseBytes) {
      // print('This is my $b');
    }
    return helloResponse;
  }
}
