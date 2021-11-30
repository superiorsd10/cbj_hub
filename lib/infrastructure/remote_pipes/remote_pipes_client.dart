import 'dart:async';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/generic_devices/generic_ping_device/generic_ping_entity.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/generic_devices/generic_ping_device/generic_ping_device_dtos.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:rxdart/rxdart.dart';

class RemotePipesClient {
  static ClientChannel? channel;
  static CbjHubClient? stub;
  static Timer? grpcKeepAlive;

  // createStreamWithRemotePipes
  ///  Turn smart device on
  static Future<void> createStreamWithHub(
    String addressToHub,
    int hubPort,
  ) async {
    channel = await _createCbjHubClient(addressToHub, hubPort);
    stub = CbjHubClient(channel!);

    ResponseStream<ClientStatusRequests> response;

    grpcDartKeepAliveWorkaround(HubRequestsToApp.streamRequestsToApp);

    try {
      response = stub!.hubTransferDevices(
        /// Transfer all requests from hub to the remote pipes->app
        HubRequestsToApp.streamRequestsToApp
            .map((DeviceEntityDtoAbstract deviceEntityDto) {
          if (deviceEntityDto is! GenericPingDeviceDtos) {
            grpcDartKeepAliveWorkaround(HubRequestsToApp.streamRequestsToApp);
          }
          return RequestsAndStatusFromHub(
            sendingType: SendingType.deviceType,
            allRemoteCommands:
                DeviceHelper.convertDtoToJsonString(deviceEntityDto),
          );
        }).handleError((error) => logger.e('Stream have error $error')),
      );

      /// All responses from the app->remote pipes going int the hub
      getIt<IAppCommunicationRepository>().getFromApp(response);
    } catch (e) {
      logger.e('Caught error: $e');
      await channel?.shutdown();
    }
  }

  /// Workaround until gRPC dart implement keep alive
  /// https://github.com/grpc/grpc-dart/issues/157
  static Future<void> grpcDartKeepAliveWorkaround(
    BehaviorSubject<DeviceEntityDtoAbstract> sendRequest,
  ) async {
    grpcKeepAlive?.cancel();
    final GenericPingDE genericEmptyDE = GenericPingDE.empty();
    grpcKeepAlive = Timer.periodic(const Duration(minutes: 9), (Timer t) {
      logger.v('Ping device to Remote Pipes');
      sendRequest.add(genericEmptyDE.toInfrastructure());
    });
  }

  static Future<ClientChannel> _createCbjHubClient(
    String deviceIp,
    int hubPort,
  ) async {
    await channel?.shutdown();
    return ClientChannel(
      deviceIp,
      port: hubPort,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }
}
