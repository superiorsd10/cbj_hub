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
    setUpAllFromDb();
  }

  static HashMap<String, DeviceEntityAbstract> allDevices =
      HashMap<String, DeviceEntityAbstract>();

  static HashMap<String, RoomEntity> allRooms = HashMap<String, RoomEntity>();

  Future<void> setUpAllFromDb() async {
    /// Delay inorder for the Hive boxes to initialize
    /// In case you got the following error:
    /// "HiveError: You need to initialize Hive or provide a path to store
    /// the box."
    /// Please increase the duration
    await Future.delayed(const Duration(milliseconds: 100));
    getIt<ILocalDbRepository>().getRoomsFromDb().then((value) {
      value.fold((l) => null, (r) {
        final Iterable<MapEntry<String, RoomEntity>> devicesAsIterableMap =
            r.map((e) {
          return MapEntry<String, RoomEntity>(
            e.uniqueId.getOrCrash(),
            e,
          );
        });
        allRooms.clear();
        allRooms.addEntries(devicesAsIterableMap);
      });
    });

    getIt<ILocalDbRepository>().getSmartDevicesFromDb().then((value) {
      value.fold((l) => null, (r) {
        final Iterable<MapEntry<String, DeviceEntityAbstract>>
            devicesAsIterableMap = r.map((e) {
          return MapEntry<String, DeviceEntityAbstract>(
            e.uniqueId.getOrCrash(),
            e,
          );
        });
        allDevices.clear();
        allDevices.addEntries(devicesAsIterableMap);
      });
    });
  }

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
    final DeviceEntityAbstract? deviceExistByIdOfVendor =
        findDeviceIfAlreadyBeenAdded(deviceEntity);

    /// Check if device already exist
    if (deviceExistByIdOfVendor != null) {
      deviceEntity.uniqueId = deviceExistByIdOfVendor.uniqueId;
      allDevices[deviceExistByIdOfVendor.uniqueId.getOrCrash()] = deviceEntity;
      return 'Device already exist';
    }

    final String entityId = deviceEntity.getDeviceId();

    /// If it is new device
    allDevices[entityId] = deviceEntity;

    final String discoveredRoomId =
        RoomUniqueId.discoveredRoomId().getOrCrash();

    if (allRooms[discoveredRoomId] == null) {
      allRooms.addEntries([MapEntry(discoveredRoomId, RoomEntity.empty())]);
    }

    allRooms[discoveredRoomId]!.addDeviceId(deviceEntity.uniqueId.getOrCrash());

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

    return 'Adding new device';
  }

  /// Check if allDevices does not contain the same device already
  /// Will compare the unique id's that each company sent us
  DeviceEntityAbstract? findDeviceIfAlreadyBeenAdded(
      DeviceEntityAbstract deviceEntity) {
    for (final DeviceEntityAbstract deviceTemp in allDevices.values) {
      if (deviceEntity.vendorUniqueId.getOrCrash() ==
          deviceTemp.vendorUniqueId.getOrCrash()) {
        return deviceTemp;
      }
    }
    return null;
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

    await removeSameDevicesFromOtherRooms(roomEntity);

    if (allRooms[roomId] == null) {
      allRooms.addEntries([MapEntry(roomId, roomEntity)]);
    } else {
      allRooms[roomId] = roomEntity;
    }
    await getIt<ILocalDbRepository>().saveSmartDevices(
        deviceList: List<DeviceEntityAbstract>.from(allDevices.values));

    return getIt<ILocalDbRepository>()
        .saveRoomsToDb(roomsList: List<RoomEntity>.from(allRooms.values));
  }

  /// Remove all devices ID in our room from all other rooms to prevent
  /// duplicate
  Future<void> removeSameDevicesFromOtherRooms(RoomEntity roomEntity) async {
    final List<String> devicesIdInTheRoom =
        List.from(roomEntity.roomDevicesId.getOrCrash());
    if (devicesIdInTheRoom.isEmpty) {
      return;
    }

    for (final RoomEntity roomEntityTemp in allRooms.values) {
      if (roomEntityTemp.roomDevicesId.failureOrUnit != right(unit)) {
        continue;
      }
      final List<String> roomIdesTempList =
          List.from(roomEntityTemp.roomDevicesId.getOrCrash());

      for (final String roomIdTemp in roomIdesTempList) {
        final int indexOfDeviceId = devicesIdInTheRoom.indexOf(roomIdTemp);

        /// If device id exist in other room than delete it from that room
        if (indexOfDeviceId != -1) {
          roomEntityTemp.deleteIdIfExist(roomIdTemp);

          devicesIdInTheRoom.removeAt(indexOfDeviceId);
          if (devicesIdInTheRoom.isEmpty) {
            return;
          }
          continue;
        }
      }
    }
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
