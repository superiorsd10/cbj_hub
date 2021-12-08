import 'dart:collection';

import 'package:cbj_hub/application/connector/connector.dart';
import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/remote_pipes/remote_pipes_entity.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/room/value_objects_room.dart';
import 'package:cbj_hub/domain/saved_devices/i_saved_devices_repo.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/remote_pipes/remote_pipes_dtos.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedDevicesRepo)
class SavedDevicesRepo extends ISavedDevicesRepo {
  SavedDevicesRepo() {
    allDevices = getIt<ILocalDbRepository>().getSmartDevicesFromDb();
    allRooms = getIt<ILocalDbRepository>().getRoomsFromDb();
  }

  static HashMap<String, DeviceEntityAbstract> allDevices =
      HashMap<String, DeviceEntityAbstract>();

  static HashMap<String, RoomEntity> allRooms = HashMap<String, RoomEntity>();

  @override
  String addOrUpdateFromMqtt(dynamic updateFromMqtt) {
    if (updateFromMqtt is DeviceEntityAbstract) {
      return addOrUpdateDevice(updateFromMqtt);
    } else {
      logger.w('Add or update type from MQTT not supported');
    }
    return 'Fail';
  }

  @override
  String addOrUpdateDevice(DeviceEntityAbstract deviceEntity) {
    final String entityId = deviceEntity.getDeviceId();
    if (allDevices[entityId] != null) {
      allDevices[entityId] = deviceEntity;
    } else {
      /// If it is new device
      allDevices[entityId] = deviceEntity;

      final String discoveredRoomId =
          RoomUniqueId.discoveredRoomId().getOrCrash();
      allRooms[discoveredRoomId]!
          .addDeviceId(deviceEntity.uniqueId.getOrCrash()!);

      ConnectorStreamToMqtt.toMqttController.sink.add(
        MapEntry<String, DeviceEntityAbstract>(
          entityId,
          allDevices[entityId]!,
        ),
      );
      ConnectorStreamToMqtt.toMqttController.sink.add(
        MapEntry<String, RoomEntity>(
          discoveredRoomId,
          allRooms[discoveredRoomId]!,
        ),
      );
    }

    return 'add or updated success';
  }

  @override
  Future<Map<String, DeviceEntityAbstract>> getAllDevices() async {
    return allDevices;
  }

  @override
  Future<Map<String, RoomEntity>> getAllRooms() async {
    return allRooms;
  }

  @override
  String addOrUpdateRoom(RoomEntity roomEntity) {
    // TODO: implement addOrUpdateRoom
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveAndActiveRoomToDb({
    required RoomEntity roomEntity,
  }) async {
    final String roomId = roomEntity.uniqueId.getOrCrash();

    if (allRooms[roomId] == null) {
      allRooms.addEntries([MapEntry(roomId, roomEntity)]);
    } else {
      allRooms[roomId] = roomEntity;
    }
    return getIt<ILocalDbRepository>()
        .saveRoomsToDb(roomsList: List<RoomEntity>.from(allRooms.values));
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveAndActivateRemotePipesDomainToDb({
    required RemotePipesEntity remotePipes,
  }) async {
    final RemotePipesDtos remotePipesDtos = remotePipes.toInfrastructure();

    final String rpDomainName = remotePipesDtos.domainName;

    getIt<IAppCommunicationRepository>()
        .startRemotePipesConnection(rpDomainName);

    return getIt<ILocalDbRepository>()
        .saveRemotePipes(remotePipesDomainName: rpDomainName);
  }

  @override
  Future<Either<LocalDbFailures, Unit>>
      saveAndActivateVendorLoginCredentialsDomainToDb({
    required LoginEntityAbstract loginEntity,
  }) async {
    CompanysConnectorConjector.setVendorLoginCredentials(loginEntity);

    return getIt<ILocalDbRepository>()
        .saveVendorLoginCredentials(loginEntityAbstract: loginEntity);
  }
}
