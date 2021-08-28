import 'dart:typed_data';

class SwitcherApiObject {
  SwitcherApiObject({
    required this.ipAddress,
    required this.deviceId,
    required this.deviceType,
    required this.deviceState,
    this.autoShutdown,
    this.electricCurrent,
    this.lastDataUpdate,
    this.macAddress,
    this.name,
    this.powerConsumption,
    this.remainingTime,
  });

  factory SwitcherApiObject.fromBytes(
      {required String ipAddress, required Uint8List bytes}) {
    final SwitcherDevicesTypes sDeviceType = getDeviceType(bytes);
    final String deviceId = getDeviceId(bytes);
    final SwitcherDeviceState deviceState = getDeviceState(bytes);

    return SwitcherApiObject(
        ipAddress: ipAddress,
        deviceId: deviceId,
        deviceType: sDeviceType,
        deviceState: deviceState);
  }

  String ipAddress;
  String deviceId;
  SwitcherDevicesTypes deviceType;
  SwitcherDeviceState deviceState;

  String? autoShutdown;
  String? electricCurrent;
  String? lastDataUpdate;
  String? macAddress;
  String? name;
  String? powerConsumption;
  String? remainingTime;

  static SwitcherDevicesTypes getDeviceType(Uint8List bytes) {
    SwitcherDevicesTypes sDevicesTypes = SwitcherDevicesTypes.notRecognized;
    final List<String> hexData = [];

    for (final int byte in bytes) {
      hexData.add(byte.toRadixString(16));
    }

    // TODO: Fix Switcher Runner (blinds) is being recognized as switcherV2Esp
    final String hexModel = hexData.sublist(75, 76)[0];

    if (hexModel == '0f') {
      sDevicesTypes = SwitcherDevicesTypes.switcherMini;
    } else if (hexModel == 'a8') {
      sDevicesTypes = SwitcherDevicesTypes.switcherPowerPlug;
    } else if (hexModel == '0b') {
      sDevicesTypes = SwitcherDevicesTypes.switcherTouch;
    } else if (hexModel == 'a7') {
      sDevicesTypes = SwitcherDevicesTypes.switcherV2Esp;
    } else if (hexModel == 'a1') {
      sDevicesTypes = SwitcherDevicesTypes.switcherV2qualcomm;
    } else if (hexModel == '17') {
      sDevicesTypes = SwitcherDevicesTypes.switcherV4;
    } else {
      print('New device type? hexModel:$hexModel');
    }

    return sDevicesTypes;
  }

  static String getDeviceId(Uint8List bytes) {
    final List<String> hexData = [];

    for (final int byte in bytes) {
      hexData.add(byte.toRadixString(16));
    }

    final List<String> hexSeparatedLetters = [];

    for (final String hexValue in hexData) {
      hexValue.runes.forEach((element) {
        hexSeparatedLetters.add(String.fromCharCode(element));
      });
    }

    return hexSeparatedLetters.sublist(24, 30).join();
  }

  static SwitcherDeviceState getDeviceState(Uint8List bytes) {
    final SwitcherDeviceState switcherDeviceState =
        SwitcherDeviceState.cantGetState;
    final List<String> hexData = [];

    for (int byte in bytes) {
      hexData.add(byte.toRadixString(16));
    }

    final List<String> hexSeparatedLetters = [];

    for (final String hexValue in hexData) {
      hexValue.runes.forEach((element) {
        hexSeparatedLetters.add(String.fromCharCode(element));
      });
    }

    final List<int> hexSeparatedAsInt = [];
    for (final String hexLetter in hexSeparatedLetters) {
      hexSeparatedAsInt.add(hexLetter.codeUnitAt(0));
    }

    SwitcherDeviceState switcherDeviceStateTemp =
        SwitcherDeviceState.cantGetState;

    if (hexSeparatedAsInt == '0100') {
      switcherDeviceStateTemp = SwitcherDeviceState.on;
    } else if (hexSeparatedAsInt == '0000') {
      switcherDeviceStateTemp = SwitcherDeviceState.off;
    }

    return switcherDeviceState;
  }
}

enum SwitcherDeviceState {
// """Enum class representing the device's state."""
//
// ON = "0100", "on"
// OFF = "0000", "off"
  cantGetState,
  on,
  off,
}

enum SwitcherDevicesTypes {
  // """Enum for relaying the type of the switcher devices."""
  //
  // MINI = "Switcher Mini", "0f", DeviceCategory.WATER_HEATER
  // POWER_PLUG = "Switcher Power Plug", "a8", DeviceCategory.POWER_PLUG
  // TOUCH = "Switcher Touch", "0b", DeviceCategory.WATER_HEATER
  // V2_ESP = "Switcher V2 (esp)", "a7", DeviceCategory.WATER_HEATER
  // V2_QCA = "Switcher V2 (qualcomm)", "a1", DeviceCategory.WATER_HEATER
  // V4 = "Switcher V4", "17", DeviceCategory.WATER_HEATER
  //
  notRecognized,
  switcherMini,
  switcherPowerPlug,
  switcherTouch,
  switcherV2Esp,
  switcherV2qualcomm,
  switcherV4,
}
