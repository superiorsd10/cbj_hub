import 'package:cbj_hub/application/boot_up/boot_up.dart';
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

  BootUp();
}
