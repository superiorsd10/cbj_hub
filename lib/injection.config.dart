// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/app_communication/i_app_communication_repository.dart' as _i5;
import 'domain/mqtt_server/i_mqtt_server_repository.dart' as _i9;
import 'domain/saved_devices/i_saved_devices_repo.dart' as _i11;
import 'domain/saved_devices/local_db/i_local_db_repository.dart' as _i7;
import 'infrastructure/app_communication/app_communication_repository.dart'
    as _i6;
import 'infrastructure/devices/esphome/esphome_connector_conjector.dart' as _i3;
import 'infrastructure/devices/google/google_connector_conjector.dart' as _i4;
import 'infrastructure/devices/lifx/lifx_connector_conjector.dart' as _i13;
import 'infrastructure/devices/philips_hue/philips_hue_connector_conjector.dart'
    as _i14;
import 'infrastructure/devices/switcher/switcher_connector_conjector.dart'
    as _i15;
import 'infrastructure/devices/tasmota/tasmota_connector_conjector.dart'
    as _i16;
import 'infrastructure/devices/tuya_smart/tuya_smart_connector_conjector.dart'
    as _i17;
import 'infrastructure/devices/xiaomi_io/xiaomi_io_connector_conjector.dart'
    as _i18;
import 'infrastructure/devices/yeelight/yeelight_connector_conjector.dart'
    as _i19;
import 'infrastructure/mqtt_server/mqtt_server_repository.dart' as _i10;
import 'infrastructure/saved_devices/local_db/local_db_repository.dart' as _i8;
import 'infrastructure/saved_devices/saved_devices_repo.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ESPHomeConnectorConjector>(_i3.ESPHomeConnectorConjector());
  gh.singleton<_i4.GoogleConnectorConjector>(_i4.GoogleConnectorConjector());
  gh.lazySingleton<_i5.IAppCommunicationRepository>(
      () => _i6.AppCommunicationRepository());
  gh.lazySingleton<_i7.ILocalDbRepository>(() => _i8.LocalDbRepository());
  gh.lazySingleton<_i9.IMqttServerRepository>(
      () => _i10.MqttServerRepository());
  gh.lazySingleton<_i11.ISavedDevicesRepo>(() => _i12.SavedDevicesRepo());
  gh.singleton<_i13.LifxConnectorConjector>(_i13.LifxConnectorConjector());
  gh.singleton<_i14.PhilipsHueConnectorConjector>(
      _i14.PhilipsHueConnectorConjector());
  gh.singleton<_i15.SwitcherConnectorConjector>(
      _i15.SwitcherConnectorConjector());
  gh.singleton<_i16.TasmotaConnectorConjector>(
      _i16.TasmotaConnectorConjector());
  gh.singleton<_i17.TuyaSmartConnectorConjector>(
      _i17.TuyaSmartConnectorConjector());
  gh.singleton<_i18.XiaomiIoConnectorConjector>(
      _i18.XiaomiIoConnectorConjector());
  gh.singleton<_i19.YeelightConnectorConjector>(
      _i19.YeelightConnectorConjector());
  return get;
}
