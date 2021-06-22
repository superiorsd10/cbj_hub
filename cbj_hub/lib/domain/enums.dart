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
  ///  Convert Raspberry Pi type to string
  static String RaspberryPiTypeToString(RaspberryPiType raspberryPiType) {
    return raspberryPiType.toString().replaceAll('RaspberryPiType.', '');
  }

  static RaspberryPiType? stringToRaspberryPiType(
      String raspberryPiTypeString) {
    for (final RaspberryPiType raspberryPiType in RaspberryPiType.values) {
      if (RaspberryPiTypeToString(raspberryPiType) == raspberryPiTypeString) {
        return raspberryPiType;
      }
    }
    return null;
  }

  ///  Convert physicalDeviceType to string
  static String physicalDeviceTypeToString(PhysicalDeviceType? deviceType) {
    return deviceType.toString().replaceAll('PhysicalDeviceType.', '');
  }
}
