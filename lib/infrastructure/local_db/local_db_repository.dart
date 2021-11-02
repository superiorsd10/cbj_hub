import 'package:cbj_hub/domain/app_communication/i_app_communication_repository.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_value_objects.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/remote_pipes/remote_pipes_entity.dart';
import 'package:cbj_hub/infrastructure/core/singleton/my_singleton.dart';
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
import 'package:cbj_hub/infrastructure/remote_pipes/remote_pipes_dtos.dart';
import 'package:cbj_hub/infrastructure/system_commands/system_commands_manager_d.dart';
import 'package:cbj_hub/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocalDbRepository)
class HiveRepository extends ILocalDbRepository {
  HiveRepository() {
    asyncConstractor();
  }

  Future<void> asyncConstractor() async {
    String hiveFolderPath;
    final String? snapCommonEnvironmentVariablePath =
        await SystemCommandsManager().getSnapCommonEnvironmentVariable();
    if (snapCommonEnvironmentVariablePath == null) {
      final String? currentUserName = await MySingleton.getCurrentUserName();
      hiveFolderPath = '/home/$currentUserName/Documents/hive';
    } else {
      // /var/snap/cybear-jinni/common/hive
      hiveFolderPath = '$snapCommonEnvironmentVariablePath/hive';
    }

    Hive.registerAdapter(RemotePipesHiveModelAdapter());
    Hive.registerAdapter(HubEntityHiveModelAdapter());
  }

  @override
  Map<String, DeviceEntityAbstract> getSmartDevicesFromDb() {
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

    return {
      // yeelightDE.uniqueId.getOrCrash()!: yeelightDE,
      // tasmotaLedDE.uniqueId.getOrCrash()!: tasmotaLedDE,
      // espHomeLightDE.uniqueId.getOrCrash()!: espHomeLightDE,
      // chromeCastEntity.uniqueId.getOrCrash()!: chromeCastEntity,
    };
  }

  @override
  Future<void>  saveSmartDevices(List<DeviceEntityAbstract> deviceList) async  {
    // TODO: implement saveSmartDevices
  }

  @override
  Future<Either<LocalDbFailures, Unit>> saveAndActivateRemotePipesDomainToDb(
    RemotePipesEntity remotePipes,
  ) async {
    final RemotePipesDtos remotePipesDtos = remotePipes.toInfrastructure();

    final String rpDomainName = remotePipesDtos.domainName;

    getIt<IAppCommunicationRepository>()
        .startRemotePipesConnection(rpDomainName);

    return saveRemotePipes(remotePipesDomainName: rpDomainName);
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
  Future<Either<LocalDbFailures, String>> getHubEntityNetworkName() async  {
    // TODO: implement getHubEntityNetworkName
    throw UnimplementedError();
  }

  @override
  Future<Either<LocalDbFailures, String>> getRemotePipesDnsName() async  {
    // TODO: implement getRemotePipesDnsName
    throw UnimplementedError();
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
  Future<Either<LocalDbFailures, Unit>> saveRemotePipes({
    required String remotePipesDomainName,
  }) async {

    /// TODO: Save the remote pipes info to local storage
    return right(unit);
  }
}
