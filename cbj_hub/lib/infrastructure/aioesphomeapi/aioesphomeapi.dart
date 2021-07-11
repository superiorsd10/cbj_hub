import 'dart:io';
import 'dart:typed_data';

import 'package:cbj_hub/infrastructure/gen/aioesphomeapi/protoc_as_dart/aioesphomeapi/api.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class AioEspHomeApi {
  static ClientChannel? channel;
  static APIConnectionClient? stub;

  static deviceInfo() {}

  ///  Turn smart device on
  static Future<void> createStreamWithHub(String addressToHub) async {
    channel = await createCbjHubClient(addressToHub);

    DeviceInfoResponse response = DeviceInfoResponse();
    HelloRequest helloRequest = HelloRequest(clientInfo: 'aioesphomeapi');
    final ConnectRequest connectRequest = ConnectRequest();
    DisconnectRequest disconnectRequest = DisconnectRequest.create();
    try {
      // print('Now');
      // final DisconnectResponse b =
      //     await APIConnectionClient(channel!).disconnect(disconnectRequest);
      // print('Hello $b');
      final ConnectResponse a = await APIConnectionClient(channel!).connect(
        connectRequest,
      );
      print('Connect Response $a');

      // stub = APIConnectionClient(
      //   channel!,
      // );
      // final DeviceInfoRequest deviceInfoRequest = DeviceInfoRequest.create();

      // response = await stub!.device_info(deviceInfoRequest);
    } catch (e) {
      print('Caught error: $e');
      await channel?.shutdown();
    }
    print('response:${response.name.toString()}');
  }

  static Future<ClientChannel> createCbjHubClient(String deviceIp) async {
    await channel?.shutdown();

    final String myPath =
        '/home/guy/Documents/programming/git/CBJ_Smart-Home/CBJ_Hub/cbj_hub/lib/infrastructure/aioesphomeapi/cacert.pem';
    final File f = File(myPath);
    final Uint8List trustedRoot = f.readAsBytesSync();

    final channelCredentials =
        ChannelCredentials.secure(certificates: trustedRoot);
    final channelOptions = ChannelOptions(credentials: channelCredentials);

    return channel = ClientChannel(
      deviceIp,
      port: 6053,
      options: channelOptions,
    );

    // final channel2 = ClientChannel(deviceIp,
    //     port: 6053,
    //     options: ChannelOptions(
    //       credentials: ClientCertificateChannelCredentials(cert, key, pass),
    //     ));
  }
}

class ClientCertificateChannelCredentials extends ChannelCredentials {
  final List<int> _cert;
  final List<int> _key;
  final String _pass;

  const ClientCertificateChannelCredentials(
    this._cert,
    this._key,
    this._pass,
  ) : super.secure();

  @override
  SecurityContext get securityContext {
    return SecurityContext(withTrustedRoots: true)
      ..useCertificateChainBytes(_cert)
      ..usePrivateKeyBytes(_key, password: _pass)
      ..setAlpnProtocols(supportedAlpnProtocols, false);
  }
}
