// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/app_communication/i_app_communication_repository.dart' as _i6;
import 'domain/local_db/i_local_db_repository.dart' as _i8;
import 'domain/mqtt_server/i_mqtt_server_repository.dart' as _i10;
import 'domain/node_red/i_node_red_repository.dart' as _i12;
import 'domain/rooms/i_saved_rooms_repo.dart' as _i18;
import 'domain/routine/i_routine_cbj_repository.dart' as _i14;
import 'domain/saved_devices/i_saved_devices_repo.dart' as _i16;
import 'domain/scene/i_scene_cbj_repository.dart' as _i20;
import 'infrastructure/app_communication/app_communication_repository.dart'
    as _i7;
import 'infrastructure/bindings/binding_repository.dart' as _i3;
import 'infrastructure/devices/esphome/esphome_connector_conjector.dart' as _i4;
import 'infrastructure/devices/google/google_connector_conjector.dart' as _i5;
import 'infrastructure/devices/lifx/lifx_connector_conjector.dart' as _i22;
import 'infrastructure/devices/philips_hue/philips_hue_connector_conjector.dart'
    as _i23;
import 'infrastructure/devices/switcher/switcher_connector_conjector.dart'
    as _i24;
import 'infrastructure/devices/tasmota/tasmota_connector_conjector.dart'
    as _i25;
import 'infrastructure/devices/tuya_smart/tuya_smart_connector_conjector.dart'
    as _i26;
import 'infrastructure/devices/xiaomi_io/xiaomi_io_connector_conjector.dart'
    as _i27;
import 'infrastructure/devices/yeelight/yeelight_connector_conjector.dart'
    as _i28;
import 'infrastructure/local_db/local_db_repository.dart' as _i9;
import 'infrastructure/mqtt_server/mqtt_server_repository.dart' as _i11;
import 'infrastructure/node_red/node_red_repository.dart' as _i13;
import 'infrastructure/room/saved_rooms_repo.dart' as _i19;
import 'infrastructure/routines/routine_repository.dart' as _i15;
import 'infrastructure/saved_devices/saved_devices_repo.dart' as _i17;
import 'infrastructure/scenes/scene_repository.dart'
    as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.BindingCbjRepository>(() => _i3.BindingCbjRepository());
  gh.singleton<_i4.ESPHomeConnectorConjector>(_i4.ESPHomeConnectorConjector());
  gh.singleton<_i5.GoogleConnectorConjector>(_i5.GoogleConnectorConjector());
  gh.lazySingleton<_i6.IAppCommunicationRepository>(
      () => _i7.AppCommunicationRepository());
  gh.lazySingleton<_i8.ILocalDbRepository>(() => _i9.HiveRepository());
  gh.lazySingleton<_i10.IMqttServerRepository>(
      () => _i11.MqttServerRepository());
  gh.lazySingleton<_i12.INodeRedRepository>(() => _i13.NodeRedRepository());
  gh.lazySingleton<_i14.IRoutineCbjRepository>(
      () => _i15.RoutineCbjRepository());
  gh.lazySingleton<_i16.ISavedDevicesRepo>(() => _i17.SavedDevicesRepo());
  gh.lazySingleton<_i18.ISavedRoomsRepo>(() => _i19.SavedRoomsRepo());
  gh.lazySingleton<_i20.ISceneCbjRepository>(() => _i21.SceneCbjRepository());
  gh.singleton<_i22.LifxConnectorConjector>(_i22.LifxConnectorConjector());
  gh.singleton<_i23.PhilipsHueConnectorConjector>(
      _i23.PhilipsHueConnectorConjector());
  gh.singleton<_i24.SwitcherConnectorConjector>(
      _i24.SwitcherConnectorConjector());
  gh.singleton<_i25.TasmotaConnectorConjector>(
      _i25.TasmotaConnectorConjector());
  gh.singleton<_i26.TuyaSmartConnectorConjector>(
      _i26.TuyaSmartConnectorConjector());
  gh.singleton<_i27.XiaomiIoConnectorConjector>(
      _i27.XiaomiIoConnectorConjector());
  gh.singleton<_i28.YeelightConnectorConjector>(
      _i28.YeelightConnectorConjector());
  return get;
}
