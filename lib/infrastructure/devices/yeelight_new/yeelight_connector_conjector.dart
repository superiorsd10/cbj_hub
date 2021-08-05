import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/abstract_company_connector_conjector.dart';

class YeelightConnectorConjector implements AbstractCompanyConnectorConjector {
  @override
  List<DeviceEntityAbstract> companyDevices = <DeviceEntityAbstract>[];
}
