// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/app_communication/i_app_communication_repository.dart' as _i3;
import 'domain/local_db/i_local_db_repository.dart' as _i5;
import 'domain/mqtt_server/i_mqtt_server_repository.dart' as _i7;
import 'domain/saved_devices/i_saved_devices_repo.dart' as _i9;
import 'infrastructure/app_communication/app_communication_repository.dart'
    as _i4;
import 'infrastructure/devices/esphome/esphome_connector_conjector.dart'
    as _i11;
import 'infrastructure/devices/switcher/switcher_connector_conjector.dart'
    as _i12;
import 'infrastructure/devices/tasmota/tasmota_connector_conjector.dart'
    as _i13;
import 'infrastructure/devices/yeelight/yeelight_connector_conjector.dart'
    as _i14;
import 'infrastructure/local_db/local_db_repository.dart' as _i6;
import 'infrastructure/mqtt_server/mqtt_server_repository.dart' as _i8;
import 'infrastructure/saved_devices/saved_devices_repo.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IAppCommunicationRepository>(
      () => _i4.AppCommunicationRepository());
  gh.lazySingleton<_i5.ILocalDbRepository>(() => _i6.LocalDbRepository());
  gh.lazySingleton<_i7.IMqttServerRepository>(() => _i8.MqttServerRepository());
  gh.lazySingleton<_i9.ISavedDevicesRepo>(() => _i10.SavedDevicesRepo());
  gh.singleton<_i11.ESPHomeConnectorConjector>(
      _i11.ESPHomeConnectorConjector());
  gh.singleton<_i12.SwitcherConnectorConjector>(
      _i12.SwitcherConnectorConjector());
  gh.singleton<_i13.TasmotaConnectorConjector>(
      _i13.TasmotaConnectorConjector());
  gh.singleton<_i14.YeelightConnectorConjector>(
      _i14.YeelightConnectorConjector());
  return get;
}
