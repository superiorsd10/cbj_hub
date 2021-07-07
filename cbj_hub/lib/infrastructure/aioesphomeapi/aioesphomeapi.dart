import 'package:cbj_hub/infrastructure/gen/aioesphomeapi/protoc_as_dart/aioesphomeapi/api.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class AioEspHomeApi {
  static ClientChannel? channel;
  static APIConnectionClient? stub;

  static deviceInfo() {}

  ///  Turn smart device on
  static Future<void> createStreamWithHub(String addressToHub) async {
    channel = await createCbjHubClient(addressToHub);
    stub = APIConnectionClient(channel!);
    ResponseFuture<DeviceInfoResponse> response;
    DeviceInfoRequest deviceInfoRequest = DeviceInfoRequest();
    try {
      response = stub!.device_info(deviceInfoRequest);
    } catch (e) {
      print('Caught error: $e');
      await channel?.shutdown();
    }
  }

  static Future<ClientChannel> createCbjHubClient(String deviceIp) async {
    await channel?.shutdown();
    return ClientChannel(deviceIp,
        port: 6053,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
  }
}
