import 'package:cbj_hub/application/boot_up/boot_up.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/devices/abstact_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/device_helper/device_helper.dart';
import 'package:cbj_hub/infrastructure/manage_physical_components/device_pin_manager.dart';
import 'package:cbj_hub/infrastructure/shared_variables.dart';
import 'package:cbj_hub/injection.dart';

void main(List<String> arguments) async {
  await configureInjection(Env.prod);

  try {
    SharedVariables(arguments[0]);
  } catch (error) {
    print('Path/argument 1 is not specified');
    print('error: $error');
  }

  //  Setting device model and checking if configuration for this model exist
  await DevicePinListManager().setPhysicalDeviceType();

  print('');
  DeviceEntityDtoAbstract a = DeviceHelper.convertDomainToDto(
      getIt<ILocalDbRepository>().getSmartDevices()[1]);
  DeviceHelper.convertDtoToDomain(a);

  await BootUp.setup();
}
