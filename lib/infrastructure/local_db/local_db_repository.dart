import 'dart:collection';

import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_value_objects.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/room/room_entity.dart';
import 'package:cbj_hub/domain/room/value_objects_room.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/login_entity_abstract.dart';
import 'package:cbj_hub/domain/vendors/login_abstract/value_login_objects_core.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_entity.dart';
import 'package:cbj_hub/domain/vendors/tuya_login/generic_tuya_login_value_objects.dart';
import 'package:cbj_hub/infrastructure/core/singleton/my_singleton.dart';
import 'package:cbj_hub/infrastructure/devices/companys_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_light/esphome_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/google/chrome_cast/chrome_cast_entity.dart';
import 'package:cbj_hub/infrastructure/devices/google/google_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_led/tasmota_led_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_1se/yeelight_1se_entity.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/hub_entity_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/remote_pipes_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/rooms_hive_model.dart';
import 'package:cbj_hub/infrastructure/local_db/hive_objects/tuya_vendor_credentials_hive_model.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

/// Only ISavedDevicesRepo need to call functions here
@LazySingleton(as: ILocalDbRepository)
class HiveRepository extends ILocalDbRepository {
  HiveRepository() {
    asyncConstractor();
  }

  Future<void> asyncConstractor() async {
    String? localDbPath = await MySingleton.getLocalDbPath();

    if (localDbPath == null) {
      logger.e('Cant find local DB path');
      localDbPath = '/';
    }

    Hive.init(localDbPath);
    Hive.registerAdapter(RemotePipesHiveModelAdapter());
    Hive.registerAdapter(RoomsHiveModelAdapter());
    Hive.registerAdapter(HubEntityHiveModelAdapter());
    Hive.registerAdapter(TuyaVendorCredentialsHiveModelAdapter());
    loadFromDb();
  }

  Future<void> loadFromDb() async {
    (await getRemotePipesDnsName()).fold(
        (l) =>
            logger.w('No Remote Pipes Dns name was found in the local storage'),
        (r) {
      getIt<IAppCommunicationRepository>().startRemotePipesConnection(r);

      logger.i('Remote Pipes DNS name was "$r" found');
    });
    (await getTuyaVendorLoginCredentials()).fold((l) {}, (r) {
      CompanysConnectorConjector.setVendorLoginCredentials(r);

      logger.i('Tuya login credentials user name "$r" found');
    });
  }

  @override
  HashMap<String, DeviceEntityAbstract> getSmartDevicesFromDb() {
    final String guyRoomId = CoreUniqueId().getOrCrash()!;

    final ESPHomeLightEntity espHomeLightDE = ESPHomeLightEntity(
      uniqueId: CoreUniqueId(),
      defaultName: DeviceDefaultName('ESPHome test 1'),
      roomId: CoreUniqueId(),
      roomName: DeviceRoomName('Ami'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('ESPHome'),
      senderDeviceModel: DeviceSenderDeviceModel('LED'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('gasd34asd233asfdg'),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      lightSwitchState:
          GenericSwitchState(DeviceActions.actionNotSupported.toString()),
      espHomeSwitchKey: ESPHomeSwitchKey('1711856045'),
      deviceMdnsName: DeviceMdnsName('livingroom'),
      lastKnownIp: DeviceLastKnownIp('192.168.31.62'),
    );

    final ChromeCastEntity chromeCastEntity = ChromeCastEntity(
      uniqueId: CoreUniqueId(),
      defaultName: DeviceDefaultName('Android TV'),
      roomId: CoreUniqueId(),
      roomName: DeviceRoomName('Living Room'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('AndroidTV'),
      senderDeviceModel: DeviceSenderDeviceModel('Mi Box'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('gasd34asd233asag3fdg'),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      smartTvSwitchState: GenericSmartTvSwitchState(
        DeviceActions.actionNotSupported.toString(),
      ),
      deviceMdnsName: DeviceMdnsName('livingroomTV'),
      lastKnownIp: DeviceLastKnownIp('192.168.31.26'),
      googlePort: GooglePort('8009'),
      googleDeviceId: GoogleDeviceId('GoogleDeviceIdTest'),
    );

    final TasmotaLedEntity tasmotaLedDE = TasmotaLedEntity(
      uniqueId: CoreUniqueId(),
      defaultName: DeviceDefaultName('Tasmota test 1'),
      roomId: CoreUniqueId(),
      roomName: DeviceRoomName('Ami'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('Tasmota'),
      senderDeviceModel: DeviceSenderDeviceModel('LED'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asd233asfdggggg'),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      lightSwitchState:
          GenericSwitchState(DeviceActions.actionNotSupported.toString()),
      tasmotaDeviceTopicName: TasmotaDeviceTopicName('tasmota_D663A6'),
      tasmotaDeviceId: TasmotaDeviceId('asdas23ds'),
    );

    final Yeelight1SeEntity yeelightDE = Yeelight1SeEntity(
      uniqueId: CoreUniqueId(),
      defaultName: DeviceDefaultName('Yeelight test 1'),
      roomId: CoreUniqueId(),
      roomName: DeviceRoomName('Guy'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('yeelight'),
      senderDeviceModel: DeviceSenderDeviceModel('1SE'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asd23gggg'),
      deviceMdnsName: DeviceMdnsName('yeelink-light-colora_miap9C52'),
      lastKnownIp: DeviceLastKnownIp('192.168.31.129'),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      yeelightDeviceId: YeelightDeviceId('249185746'),
      yeelightPort: YeelightPort('55443'),
      lightSwitchState: GenericRgbwLightSwitchState(
        DeviceActions.actionNotSupported.toString(),
      ),
      lightColorTemperature: GenericRgbwLightColorTemperature(''),
      lightBrightness: GenericRgbwLightBrightness('90'),
      lightColorAlpha: GenericRgbwLightColorAlpha('1.0'),
      lightColorHue: GenericRgbwLightColorHue('0.0'),
      lightColorSaturation: GenericRgbwLightColorSaturation('1.0'),
      lightColorValue: GenericRgbwLightColorValue('1.0'),
    );

    return HashMap<String, DeviceEntityAbstract>();
    // {
    // yeelightDE.uniqueId.getOrCrash()!: yeelightDE,
    // tasmotaLedDE.uniqueId.getOrCrash()!: tasmotaLedDE,
    // espHomeLightDE.uniqueId.getOrCrash()!: espHomeLightDE,
    // chromeCastEntity.uniqueId.getOrCrash()!: chromeCastEntity,
    // };
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveSmartDevices(
    List<DeviceEntityAbstract> deviceList,
  ) async {
    // TODO: implement saveSmartDevices
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveRoomsToDb({
    required List<RoomEntity> roomsList,
  }) async {
    for (final RoomEntity roomEntity in roomsList) {
      // TODO: Save room entity to local DB
    }

    return right(unit);
  }

  @override
  Future<Either<LocalDbFailures, String>> getHubEntityLastKnownIp() async {
    // TODO: implement getHubEntityLastKnownIp
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, String>> getHubEntityNetworkBssid() async {
    // TODO: implement getHubEntityNetworkBssid
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, String>> getHubEntityNetworkName() async {
    // TODO: implement getHubEntityNetworkName
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, GenericTuyaLoginDE>>
      getTuyaVendorLoginCredentials() async {
    try {
      final Box<TuyaVendorCredentialsHiveModel> tuyaVendorCredentialsBox =
          await Hive.openBox<TuyaVendorCredentialsHiveModel>(
        tuyaVendorCredentialsBoxName,
      );

      final List<TuyaVendorCredentialsHiveModel>
          tuyaVendorCredentialsModelFromDb = tuyaVendorCredentialsBox.values
              .toList()
              .cast<TuyaVendorCredentialsHiveModel>();

      if (tuyaVendorCredentialsModelFromDb.isNotEmpty) {
        final TuyaVendorCredentialsHiveModel firstTuyaVendorFromDB =
            tuyaVendorCredentialsModelFromDb[0];

        final String? senderUniqueId = firstTuyaVendorFromDB.senderUniqueId;
        final String tuyaUserName = firstTuyaVendorFromDB.tuyaUserName;
        final String tuyaUserPassword = firstTuyaVendorFromDB.tuyaUserPassword;
        final String tuyaCountryCode = firstTuyaVendorFromDB.tuyaCountryCode;
        final String tuyaBizType = firstTuyaVendorFromDB.tuyaBizType;
        final String tuyaRegion = firstTuyaVendorFromDB.tuyaRegion;

        await tuyaVendorCredentialsBox.close();

        final GenericTuyaLoginDE genericTuyaLoginDE = GenericTuyaLoginDE(
          senderUniqueId: CoreLoginSenderId.fromUniqueString(senderUniqueId),
          tuyaUserName: GenericTuyaLoginUserName(tuyaUserName),
          tuyaUserPassword: GenericTuyaLoginUserPassword(tuyaUserPassword),
          tuyaCountryCode: GenericTuyaLoginCountryCode(tuyaCountryCode),
          tuyaBizType: GenericTuyaLoginBizType(tuyaBizType),
          tuyaRegion: GenericTuyaLoginRegion(tuyaRegion),
        );

        logger.i(
          'Tuya user name is: '
          '$tuyaUserName',
        );

        return right(genericTuyaLoginDE);
      }
      await tuyaVendorCredentialsBox.close();
      logger.i("Didn't find any remote pipes in the local DB");
    } catch (e) {
      logger.e('Local DB hive error: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, String>> getRemotePipesDnsName() async {
    try {
      final Box<RemotePipesHiveModel> remotePipesBox =
          await Hive.openBox<RemotePipesHiveModel>(remotePipesBoxName);

      final List<RemotePipesHiveModel> remotePipesHiveModelFromDb =
          remotePipesBox.values.toList().cast<RemotePipesHiveModel>();

      if (remotePipesHiveModelFromDb.isNotEmpty) {
        final String remotePipesDnsName =
            remotePipesHiveModelFromDb[0].domainName;
        await remotePipesBox.close();

        logger.i(
          'Remote pipes domain name is: '
          '$remotePipesDnsName',
        );
        return right(remotePipesDnsName);
      }
      await remotePipesBox.close();
      logger.i("Didn't find any remote pipes in the local DB");
    } catch (e) {
      logger.e('Local DB hive error: $e');
    }
    return left(const LocalDbFailures.unexpected());
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveHubEntity({
    required String hubNetworkBssid,
    required String networkName,
    required String lastKnownIp,
  }) async {
    // TODO: implement saveHubEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveVendorLoginCredentials({
    required LoginEntityAbstract loginEntityAbstract,
  }) async {
    if (loginEntityAbstract is GenericTuyaLoginDE) {
      saveTuyaVendorCredentials(tuyaLoginDE: loginEntityAbstract);
    } else {
      logger.e(
        'Please implement save function for this login type '
        '${loginEntityAbstract.runtimeType}',
      );
    }

    return right(unit);
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveRemotePipes({
    required String remotePipesDomainName,
  }) async {
    try {
      final Box<RemotePipesHiveModel> remotePipesBox =
          await Hive.openBox<RemotePipesHiveModel>(remotePipesBoxName);

      final RemotePipesHiveModel remotePipesHiveModel = RemotePipesHiveModel()
        ..domainName = remotePipesDomainName;

      if (remotePipesBox.isNotEmpty) {
        await remotePipesBox.putAt(0, remotePipesHiveModel);
      } else {
        remotePipesBox.add(remotePipesHiveModel);
      }

      await remotePipesBox.close();
      logger.i(
        'Remote Pipes got saved to local storage with domain name is: '
        '$remotePipesDomainName',
      );
    } catch (e) {
      logger.e('Error saving Remote Pipes to local storage');
      return left(const LocalDbFailures.unexpected());
    }

    return right(unit);
  }

  Future<Either<LocalDbFailures, Unit>> saveTuyaVendorCredentials({
    required GenericTuyaLoginDE tuyaLoginDE,
  }) async {
    try {
      final Box<TuyaVendorCredentialsHiveModel> tuyaVendorCredentialsBox =
          await Hive.openBox<TuyaVendorCredentialsHiveModel>(
        tuyaVendorCredentialsBoxName,
      );

      final TuyaVendorCredentialsHiveModel tuyaVendorCredentialsModel =
          TuyaVendorCredentialsHiveModel()
            ..senderUniqueId = tuyaLoginDE.senderUniqueId.getOrCrash()
            ..tuyaUserName = tuyaLoginDE.tuyaUserName.getOrCrash()
            ..tuyaUserPassword = tuyaLoginDE.tuyaUserPassword.getOrCrash()
            ..tuyaCountryCode = tuyaLoginDE.tuyaCountryCode.getOrCrash()
            ..tuyaBizType = tuyaLoginDE.tuyaBizType.getOrCrash()
            ..tuyaRegion = tuyaLoginDE.tuyaRegion.getOrCrash();

      if (tuyaVendorCredentialsBox.isNotEmpty) {
        await tuyaVendorCredentialsBox.putAt(0, tuyaVendorCredentialsModel);
      } else {
        tuyaVendorCredentialsBox.add(tuyaVendorCredentialsModel);
      }

      await tuyaVendorCredentialsBox.close();
      logger.i(
        'Tuya vendor credentials saved to local storage with the user name: '
        '${tuyaLoginDE.tuyaUserName.getOrCrash()}',
      );
    } catch (e) {
      logger.e('Error saving Remote Pipes to local storage');
      return left(const LocalDbFailures.unexpected());
    }
    return right(unit);
  }

  @override
  HashMap<String, RoomEntity> getRoomsFromDb() {
    final HashMap<String, RoomEntity> rooms = HashMap<String, RoomEntity>();

    // TODO: get all rooms from db, if there are non it will create and return
    // a discovered room

    if (rooms.isEmpty) {
      final RoomEntity discoveredRoom = RoomEntity.empty().copyWith(
        uniqueId: RoomUniqueId.discoveredRoomId(),
        defaultName: RoomDefaultName.discoveredRoomName(),
      );
      rooms.addEntries([
        MapEntry<String, RoomEntity>(
          discoveredRoom.uniqueId.getOrCrash(),
          discoveredRoom,
        )
      ]);
    }
    return rooms;
  }
}
