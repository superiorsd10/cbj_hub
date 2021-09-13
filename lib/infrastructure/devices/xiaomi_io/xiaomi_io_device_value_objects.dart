import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/xiaomi_io/xiaomi_io_device_validators.dart';
import 'package:dartz/dartz.dart';

/// XiaomiIo device unique address that came withe the device
class XiaomiIoDeviceId extends ValueObjectCore<String> {
  factory XiaomiIoDeviceId(String? input) {
    assert(input != null);
    return XiaomiIoDeviceId._(
      validateXiaomiIoIdNotEmpty(input!),
    );
  }

  const XiaomiIoDeviceId._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}

/// XiaomiIo communication port
class XiaomiIoPort extends ValueObjectCore<String> {
  factory XiaomiIoPort(String? input) {
    assert(input != null);
    return XiaomiIoPort._(
      validateXiaomiIoPortNotEmpty(input!),
    );
  }

  const XiaomiIoPort._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
