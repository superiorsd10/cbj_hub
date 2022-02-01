import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';

class EspHomeHelpers {
  static Future<List<DeviceEntityAbstract>> addDiscoverdDevice({
    required String mDnsName,
    required String? port,
  }) async {
    final List<DeviceEntityAbstract> deviceEntityList = [];

    // TODO: Search for all the entities in this device and add all of them as
    // TODO: separate devices
    // EspHomeApi espHomeApi;
    // try {
    //   espHomeApi = EspHomeApi.createWithAddress(
    //     addressOfServer: mDnsName,
    //     devicePort: port,
    //     devicePassword: 'MyPassword',
    //   );
    //   //
    //   // EspHomeApi.listenToResponses();
    //   await espHomeApi.helloRequestToEsp();
    // } catch (mDnsCannotBeFound) {
    //   espHomeApi = EspHomeApi.createWithAddress(
    //     addressOfServer: '192.168.31.77',
    //     devicePort: port,
    //     devicePassword: 'MyPassword',
    //   );
    //   //
    //   // EspHomeApi.listenToResponses();
    //   await espHomeApi.helloRequestToEsp();
    // }
    // espHomeApi.listenToResponses();
    //
    // await espHomeApi.sendConnect();
    // await espHomeApi.listEntitiesRequest();

    // await EspHomeApi.deviceInfoRequestToEsp();
    // await EspHomeApi.listEntitiesRequest();
    // await EspHomeApi.subscribeStatesRequest();
    // await espHomeApi.switchCommandRequest(
    //   int.parse(vendorUniqueId.getOrCrash()),
    //   false,
    // );
    // await espHomeApi.disconnect();

    // final String? deviceIp =
    //     await ESPHomeConnectorConjector.getIpFromMDNS(mDnsName);
    //
    // if (deviceIp == null) {
    //   return deviceEntityList;
    // }

    // final DeviceEntityAbstract espHomeDE = ESPHomeLightEntity(
    //   uniqueId: CoreUniqueId(),
    //   vendorUniqueId: VendorUniqueId(),
    //   defaultName: DeviceDefaultName('Esp test'),
    //   deviceStateGRPC: DeviceState('on'),
    //   stateMassage: DeviceStateMassage('Test'),
    //   senderDeviceOs: DeviceSenderDeviceOs('ESP'),
    //   senderDeviceModel: DeviceSenderDeviceModel('D1'),
    //   senderId: DeviceSenderId(),
    //   compUuid: DeviceCompUuid('asd'),
    //   powerConsumption: DevicePowerConsumption('null'),
    //   lightSwitchState: GenericLightSwitchState('on'),
    //   deviceMdnsName: DeviceMdnsName(mDnsName),
    //   lastKnownIp: DeviceLastKnownIp(deviceIp),
    //   devicePort: DevicePort(port),
    // );
    // deviceEntityList.add(espHomeDE);

    return deviceEntityList;
  }
}
