import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/remote_pipes/remote_pipes_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ILocalDbRepository {
  String remotePipesBoxName = 'remotePipesBox';
  String hubEntityBoxName = 'hubEntityBox';

  Future<void> saveSmartDevices(List<DeviceEntityAbstract> deviceList);

  Map<String, DeviceEntityAbstract> getSmartDevicesFromDb();

  /// Will save the remote pipes entity to the local storage and will activate
  /// connection to remote pipes with that info
  /// Will return true if complete success
  Future<Either<LocalDbFailures, Unit>> saveAndActivateRemotePipesDomainToDb(
    RemotePipesEntity remotePipes,
  );

  Future<Either<LocalDbFailures, Unit>> saveRemotePipes({
    required String remotePipesDomainName,
  });

  Future<Either<LocalDbFailures, Unit>> saveHubEntity({
    required String hubNetworkBssid,
    required String networkName,
    required String lastKnownIp,
  });

  Future<Either<LocalDbFailures, String>> getRemotePipesDnsName();

  Future<Either<LocalDbFailures, String>> getHubEntityNetworkBssid();

  Future<Either<LocalDbFailures, String>> getHubEntityNetworkName();

  Future<Either<LocalDbFailures, String>> getHubEntityLastKnownIp();
}
