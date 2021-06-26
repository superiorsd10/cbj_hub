// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mqtt_client/mqtt_server_client.dart' as _i9;

import 'domain/app_communication/i_app_communication_repository.dart' as _i3;
import 'domain/example_device/i_example_device_repository.dart' as _i5;
import 'domain/mqtt_server/i_mqtt_server_repository.dart' as _i7;
import 'domain/server_for_cbj_app/i_server_for_cbj_app_repository.dart' as _i10;
import 'infrastructure/app_communication/app_communication_repository.dart'
    as _i4;
import 'infrastructure/example_device/example_device_repository.dart' as _i6;
import 'infrastructure/mqtt_server/mqtt_server_repository.dart' as _i8;
import 'infrastructure/server_for_cbj_app/server_for_cbj_app_repository.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IAppCommunicationRepository>(
      () => _i4.AppCommunicationRepository());
  gh.lazySingleton<_i5.IExampleDeviceRepository>(
      () => _i6.ExampleDeviceRepository());
  gh.lazySingleton<_i7.IMqttServerRepository>(
      () => _i8.MqttServerRepository(get<_i9.MqttServerClient>()));
  gh.lazySingleton<_i10.IServerForCbjAppRepository>(
      () => _i11.ServerForCbjAppRepository());
  return get;
}
