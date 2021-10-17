import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cbj_hub/infrastructure/gen/aioesphomeapi/protoc_as_dart/aioesphomeapi/api.pbserver.dart';
import 'package:cbj_hub/utils.dart';

class EspHomeApi {
  EspHomeApi(this.fSocket);

  factory EspHomeApi.createWithAddress(String addressOfServer) {
    final Future<Socket> socket = Socket.connect(addressOfServer, 6053);

    return EspHomeApi(socket);
  }

  Future<Socket> fSocket;
  String? devicePass;

  Future<void> listenToResponses() async {
    final Socket socket = await fSocket;

    socket.listen(
      // handle data from the server
      (Uint8List data) {
        final int responseType = data[2];

        /// ConnectResponse
        if (responseType == 4) {
          logger.v('responseType is ConnectResponse');
          logger.v('ConnectResponse data: ${utf8.decode(data.sublist(3))}');
          logger.v('Data: $data');
          if (data.length > 3) {
            logger.v('Password is wrong');
            devicePass = null;
          } else {
            logger.v('Correct password');
          }
          logger.v('');
        }

        /// HelloResponse
        else if (responseType == 2) {
          logger.v('responseType is HelloResponse');
          final HelloResponse? helloResponseData = bytesToHelloResponse(data);
          logger.v('HelloResponse data: ${helloResponseData?.serverInfo}');
          logger.v('');
        }

        /// DeviceInfoResponse
        else if (responseType == 10) {
          logger.v('responseType is DeviceInfoResponse');
          logger.v('DeviceInfoResponse data: $data');
          logger.v('');
        }

        /// PingRequest
        else if (responseType == 7) {
          logger.v('responseType is PingResponse');
          logger.v('PingResponse data: ${utf8.decode(data.sublist(3))}');
          logger.v('');
        }

        /// PingResponse
        else if (responseType == 8) {
          logger.v('responseType is PingResponse');
          logger.v('PingResponse data: ${utf8.decode(data.sublist(3))}');
          logger.v('');
        }

        /// ListEntitiesSwitchResponse
        else if (responseType == 17) {
          logger.v('responseType is ListEntitiesSwitchResponse');
          String dataPayload = '';

          try {
            dataPayload = data.length > 3 ? utf8.decode(data.sublist(3)) : '';

            logger.v(
              'ListEntitiesSwitchResponse data payload:'
              ' $dataPayload',
            );
          } catch (e) {
            logger.v(
              'ListEntitiesSwitchResponse data bytes:'
              ' $data',
            );
          }
          logger.v('');
        }

        /// ListEntitiesDoneResponse
        else if (responseType == 19) {
          logger.v('responseType is ListEntitiesDoneResponse');
          logger.v(
            'ListEntitiesDoneResponse data: ${utf8.decode(data.sublist(3))}',
          );
          logger.v('');
        }

        /// PingResponse
        else if (responseType == 26) {
          logger.v('responseType is SwitchStateResponse');
          logger.v('SwitchStateResponse data: $data}');
          logger.v('');
        } else {
          logger.v('responseType is else');
          logger.v('Listen to data $data');
          logger.v('');
        }
      },

      // handle errors
      onError: (error) {
        logger.e(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        logger.v('Server left.');
        socket.destroy();
      },
    );
  }

  Future<void> sendConnect(String devicePassTransfer) async {
    devicePass = devicePassTransfer;
    // connect to the socket server
    final Socket socket = await fSocket;

    final ConnectRequest connectRequest =
        ConnectRequest(password: '\n\n$devicePass');

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

//  * The message object encoded as a ProtoBuf message

    for (int i = numOfByteBeforeData;
        i < list.length + numOfByteBeforeData;
        i++) {
      byteData.setUint8(i, list[i - numOfByteBeforeData]);
    }

    socket.add(message);
  }

  Future<void> disconnect() async {
    await (await fSocket).close();
  }

  ///  Turn smart device on
  Future<void> helloRequestToEsp() async {
    // connect to the socket server
    final Socket socket = await fSocket;
    const String clientName = 'aioesphomeapi';

    final HelloRequest helloRequest =
        HelloRequest(clientInfo: '\n\r$clientName');

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
    String addressToServer,
    String password,
  ) async {
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
    logger.v(
      'Connected request to: '
      '${socket.remoteAddress.address}:${socket.remotePort}',
    );

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
    logger.v(
      'Connected request to:'
      ' ${socket.remoteAddress.address}:${socket.remotePort}',
    );

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

    socket.add(message);
  }

  ///  Turn smart device on
  Future<void> subscribeStatesRequest() async {
    // connect to the socket server
    final socket = await fSocket;
    logger.v(
      'Connected request to:'
      ' ${socket.remoteAddress.address}:${socket.remotePort}',
    );

    final SubscribeStatesRequest subscribeStateReq = SubscribeStatesRequest();

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
    byteData.setUint8(2, 20);

    socket.add(message);
  }

  ///  Turn smart device on
  Future<void> switchCommandRequest(int deviceKey, bool changeTostate) async {
    if (devicePass == null) {
      logger.v('Please call sendConnect, password is missing');
      return;
    }
    // connect to the socket server
    final socket = await fSocket;
    logger.v(
      'Connected request to:'
      ' ${socket.remoteAddress.address}:${socket.remotePort}',
    );

    final SwitchCommandRequest switchCommandRequest =
        SwitchCommandRequest(key: deviceKey, state: changeTostate);

    final String myHexKey =
        switchCommandRequest.key.toRadixString(16).padLeft(4, '0');

    List<int> myHexKeyList = [];

    for (int i = 0; i < myHexKey.length; i += 2) {
      myHexKeyList.add(int.parse('0x${myHexKey.substring(i, i + 2)}'));
    }

    myHexKeyList = List.from(myHexKeyList.reversed);
    myHexKeyList.insert(0, 13);

    if (changeTostate == true) {
      myHexKeyList.add(16);
      myHexKeyList.add(1);
    }

    const int numOfByteBeforeData = 3;

    final int totalSizeToTransfer = numOfByteBeforeData + myHexKeyList.length;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    logger.v(myHexKeyList);

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, myHexKeyList.length);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 33);

    for (int a = numOfByteBeforeData;
        a < myHexKeyList.length + numOfByteBeforeData;
        a++) {
      byteData.setUint8(a, myHexKeyList[a - numOfByteBeforeData]);
    }

    logger.v('switchCommandRequest message: $message');

//  * The message object encoded as a ProtoBuf message
    socket.add(message);
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  ///  Turn smart device on
  Future<void> listEntitiesRequest() async {
    if (devicePass == null) {
      logger.v('Please call sendConnect, password is missing');
      return;
    }
    // connect to the socket server
    final socket = await fSocket;
    logger.v(
      'Connected request to:'
      ' ${socket.remoteAddress.address}:${socket.remotePort}',
    );

    final ListEntitiesRequest switchCommandRequest = ListEntitiesRequest();

    const int numOfByteBeforeData = 3;

    const int totalSizeToTransfer = numOfByteBeforeData;

    final Uint8List message = Uint8List(totalSizeToTransfer);

    final ByteData byteData = ByteData.view(message.buffer);

    /// A zero byte.
    byteData.setUint8(0, 0x00);

    /// VarInt denoting the size of the message object.
    /// (type is not part of this)
    byteData.setUint8(1, 0);

    ///  * VarInt denoting the type of message.
    byteData.setUint8(2, 11);

    logger.v('ListEntitiesRequest message: $message');

//  * The message object encoded as a ProtoBuf message
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

    return helloResponse;
  }
}
