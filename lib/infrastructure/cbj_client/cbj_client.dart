import 'dart:async';

import 'package:cbj_hub/infrastructure/gen/smart_device_server_and_client/protoc_as_dart/smart_connection.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class SmartClient {
  static ClientChannel? channel;
  static SmartServerClient? stub;

  ///  Turn smart device on
  static Future<void> createStreamWithRemotePipes(String addressToHub) async {
    channel = await createSmartServerClient(addressToHub);
    stub = SmartServerClient(channel!);
    ResponseStream<ClientStatusRequests> response;
    final Stream<RequestsAndStatusFromHub> streamClientStatusRequests =
        Stream.value(RequestsAndStatusFromHub());
    try {
      final NumberCreator n = NumberCreator();

      response = stub!.registerHub(n.stream);

      response.listen((value) {
        print('Greeter client received: $value');
      });
      // await channel!.shutdown();
      // return response.success.toString();
    } catch (e) {
      print('Caught error: $e');
    }
    // await channel!.shutdown();
    // throw 'Error';
  }

  static Future<ClientChannel> createSmartServerClient(String deviceIp) async {
    await channel?.shutdown();
    return ClientChannel(deviceIp,
        port: 50051,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
  }
}

/// Cleaner way to get grpc client types
class GrpcClientTypes {
  /// DeviceStateGRPC type
  static final deviceStateGRPCType =
      DeviceStateGRPC.stateNotSupported.runtimeType;

  /// DeviceStateGRPC type as string
  static final deviceStateGRPCTypeString =
      deviceStateGRPCType.toString().substring(0, 1).toLowerCase() +
          deviceStateGRPCType.toString().substring(1);

  /// DeviceActions type as string
  static final deviceActionsType = DeviceActions.actionNotSupported.runtimeType;

  /// DeviceActions type as string
  static final deviceActionsTypeString =
      deviceActionsType.toString().substring(0, 1).toLowerCase() +
          deviceActionsType.toString().substring(1);

  /// DeviceActions type as string
  static final deviceTypesType = DeviceTypes.typeNotSupported.runtimeType;

  /// DeviceActions type as string
  static final deviceTypesTypeString =
      deviceTypesType.toString().substring(0, 1).toLowerCase() +
          deviceTypesType.toString().substring(1);
}

class NumberCreator {
  NumberCreator() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _controller.sink.add(RequestsAndStatusFromHub());
      _count++;
    });
  }

  var _count = 1;

  final _controller = StreamController<RequestsAndStatusFromHub>();

  Stream<RequestsAndStatusFromHub> get stream => _controller.stream;
}
