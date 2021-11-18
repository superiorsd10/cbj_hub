import 'dart:io';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/app_communication/app_communication_repository.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/proto_gen_date.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:grpc/service_api.dart';

/// Server to get and send information to the app
class HubAppServer extends CbjHubServiceBase {
  /// The app call this method and getting stream of all the changes of the
  /// internet devices
  Stream<MapEntry<String, String>> streamOfChanges() async* {}

  @override
  Stream<RequestsAndStatusFromHub> clientTransferDevices(
    ServiceCall call,
    Stream<ClientStatusRequests> request,
  ) async* {
    try {
      logger.v('Got new Client');

      getIt<IAppCommunicationRepository>().getFromApp(request);

      yield* HubRequestsToApp.streamRequestsToApp
          .map(
            (DeviceEntityDtoAbstract deviceEntityDto) =>
                RequestsAndStatusFromHub(
              sendingType: SendingType.deviceType,
              allRemoteCommands:
                  DeviceHelper.convertDtoToJsonString(deviceEntityDto),
            ),
          )
          .handleError((error) => logger.e('Stream have error $error'));
    } catch (e) {
      logger.e('Hub server error $e');
    }
  }

  @override
  Future<CompHubInfo> getCompHubInfo(
    ServiceCall call,
    CompHubInfo request,
  ) async {
    logger.i('Hub info got requested');

    final CbjHubIno cbjHubIno = CbjHubIno(
      deviceName: 'cbj Hub',
      // pubspecYamlVersion: packageInfo.version,
      protoLastGenDate: hubServerProtocGenDate,
    );

    final CompHubSpecs compHubSpecs = CompHubSpecs(
      compOs: Platform.operatingSystem,
    );

    final CompHubInfo compHubInfo = CompHubInfo(
      cbjInfo: cbjHubIno,
      compSpecs: compHubSpecs,
    );
    return compHubInfo;
  }

  @override
  Stream<ClientStatusRequests> hubTransferDevices(
    ServiceCall call,
    Stream<RequestsAndStatusFromHub> request,
  ) async* {
    // TODO: implement registerHub
    throw UnimplementedError();
  }
}
