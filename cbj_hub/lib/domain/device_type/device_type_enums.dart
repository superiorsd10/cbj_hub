import 'package:cbj_hub/infrastructure/smart_device_server_and_client/protoc_as_dart/smart_connection.pbgrpc.dart';

///  List of all physical devices types
enum PhysicalDeviceType {
  NanoPiDuo2,
  NanoPiAir,
  NanoPiNeo,
  NanoPiNeo2,
  RaspberryPi,
  NotSupported,
}

enum RaspberryPiType {
  Raspberry_Pi_3_Model_B_Rev_1_2,
  Raspberry_Pi_4_Model_B_Rev_1_4,
}

class EnumHelper {
  static String dTToString(DeviceTypes deviceType) {
    return deviceType.toString().replaceAll('DeviceType.', '');
  }

  static DeviceTypes? stringToDt(String deviceTypeAsString) {
    String deviceTypeAsStringTemp = deviceTypeAsString;
    if (deviceTypeAsStringTemp.contains('Object')) {
      deviceTypeAsStringTemp = deviceTypeAsStringTemp.substring(
          0, deviceTypeAsStringTemp.indexOf('Object'));
    }
    for (final DeviceTypes deviceType in DeviceTypes.values) {
      if (dTToString(deviceType) == deviceTypeAsStringTemp) {
        return deviceType;
      }
    }
    return null;
  }

  ///  Convert deviceAction to string
  static String deviceActionToString(DeviceActions deviceAction) {
    return deviceAction.toString().replaceAll('DeviceActions.', '');
  }

  ///  Convert string to deviceAction
  static DeviceActions? stringToDeviceAction(String deviceActionString) {
    for (final DeviceActions deviceAction in DeviceActions.values) {
      if (deviceActionToString(deviceAction) == deviceActionString) {
        return deviceAction;
      }
    }
    return null;
  }

  ///  Convert deviceState to string
  static String deviceStateToString(DeviceStateGRPC deviceState) {
    return deviceState.toString().replaceAll('DeviceStateGRPC.', '');
  }

  ///  Convert string to deviceState
  static DeviceStateGRPC? stringToDeviceState(String deviceStateAsString) {
    for (final DeviceStateGRPC deviceState in DeviceStateGRPC.values) {
      if (deviceStateToString(deviceState) == deviceStateAsString) {
        return deviceState;
      }
    }
    return null;
  }

  ///  Convert physicalDeviceType to string
  static String physicalDeviceTypeToString(PhysicalDeviceType? deviceType) {
    return deviceType.toString().replaceAll('PhysicalDeviceType.', '');
  }

  /// Return the corresponding SmartDeviceBaseAbstract Object of the deviceType
  static dynamic deviceTypeToSmartDeviceBaseAbstractObject(
      DeviceTypes deviceType) {
    throw Exception('$deviceType Conditioner was not implemented yet');

    return null;
  }

  /// Returning the non abstract of this SmartDeviceBaseAbstract
  static Type getTheNonAbstractObjectOfSmartDeviceBaseAbstract(
      dynamic smartDeviceBaseAbstract, DeviceTypes deviceType) {
    throw Exception('$deviceType Conditioner was not implemented yet');
  }
}
