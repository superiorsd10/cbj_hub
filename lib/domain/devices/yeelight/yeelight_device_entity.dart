import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/yeelight/yeelight_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'yeelight_device_entity.freezed.dart';

/// Abstract smart Yeelight that exist inside a computer, the implementations
/// will be actual Yeelight like blinds lights and more
@freezed
abstract class YeelightDE implements _$YeelightDE, DeviceEntityAbstract {
  /// All public field of Yeelight entity
  const factory YeelightDE({
    /// The smart Yeelight id
    //
    required CoreUniqueId? id,

    /// The default name of the Yeelight
    required DeviceDefaultName? defaultName,

    /// Room id that the smart Yeelight located in.
    required CoreUniqueId? roomId,

    /// Room name that the smart Yeelight located in.
    required DeviceRoomName? roomName,

    /// Did the massage arrived or was it just sent.
    /// Will be 'set' (need change) or 'ack' for acknowledge
    required DeviceState? deviceStateGRPC,

    /// If state didn't change the error description will be found here.
    DeviceStateMassage? stateMassage,

    /// Sender Yeelight os type, example: android, iphone, browser
    required DeviceSenderDeviceOs? senderDeviceOs,

    /// The sender Yeelight model, example: onePlus 3T
    required DeviceSenderDeviceModel? senderDeviceModel,

    /// Last Yeelight sender id that activated the action
    required DeviceSenderId? senderId,

    /// What action to execute
    required DeviceAction? deviceActions,

    /// The smart Yeelight type
    required DeviceType? deviceTypes,

    /// Unique id of the computer that the Yeelight located in
    required DeviceCompUuid? compUuid,

    /// Yeelight device unique id that came withe the device
    required YeelightDeviceId? yeelightDeviceId,

    /// Yeelight communication port
    required YeelightPort? yeelightPort,

    /// Last known Ip of the computer that the Yeelight located in
    DeviceLastKnownIp? lastKnownIp,

    /// Yeelight power consumption in watts
    DevicePowerConsumption? powerConsumption,

    /// Yeelight mdns name
    DeviceMdnsName? deviceMdnsName,

    /// Yeelight second WiFi
    DeviceSecondWiFiName? deviceSecondWiFi,
  }) = _YeelightDE;

  const YeelightDE._();

  /// Empty instance of YeelightEntity
  factory YeelightDE.empty() => YeelightDE(
        id: CoreUniqueId(),
        defaultName: DeviceDefaultName(''),
        roomId: CoreUniqueId(),
        roomName: DeviceRoomName(''),
        deviceStateGRPC: DeviceState(''),
        senderDeviceOs: DeviceSenderDeviceOs(''),
        senderDeviceModel: DeviceSenderDeviceModel(''),
        stateMassage: DeviceStateMassage(''),
        senderId: DeviceSenderId(),
        deviceActions: DeviceAction(''),
        deviceTypes: DeviceType(''),
        compUuid: DeviceCompUuid(''),
        lastKnownIp: DeviceLastKnownIp(''),
        yeelightDeviceId: YeelightDeviceId(''),
        yeelightPort: YeelightPort(''),
      );

  /// Will return failure if any of the fields failed or return unit if fields
  /// have legit values
  Option<CoreFailure<dynamic>> get failureOption {
    return defaultName!.value.fold((f) => some(f), (_) => none());
    //
    // return body.failureOrUnit
    //     .andThen(todos.failureOrUnit)
    //     .andThen(
    //       todos
    //           .getOrCrash()
    //           // Getting the failureOption from the TodoItem ENTITY - NOT a failureOrUnit from a VALUE OBJECT
    //           .map((todoItem) => todoItem.failureOption)
    //           .filter((o) => o.isSome())
    //           // If we can't get the 0th element, the list is empty. In such a case, it's valid.
    //           .getOrElse(0, (_) => none())
    //           .fold(() => right(unit), (f) => left(f)),
    //     )
    //     .fold((f) => some(f), (_) => none());
  }

  @override
  String getDeviceId() {
    return this.id!.getOrCrash()!;
  }

  @override
  DeviceEntityDtoAbstract toInfrastructure() {
    return YeelightDtos(
      deviceDtoClass: (YeelightDtos).toString(),
      id: this.id!.getOrCrash(),
      defaultName: defaultName!.getOrCrash(),
      roomId: roomId!.getOrCrash(),
      roomName: roomName!.getOrCrash(),
      deviceStateGRPC: deviceStateGRPC!.getOrCrash(),
      stateMassage: stateMassage!.getOrCrash(),
      senderDeviceOs: senderDeviceOs!.getOrCrash(),
      senderDeviceModel: senderDeviceModel!.getOrCrash(),
      senderId: senderId!.getOrCrash(),
      deviceActions: deviceActions!.getOrCrash(),
      deviceTypes: deviceTypes!.getOrCrash(),
      compUuid: compUuid!.getOrCrash(),
      deviceSecondWiFi: deviceSecondWiFi!.getOrCrash(),
      deviceMdnsName: deviceMdnsName!.getOrCrash(),
      lastKnownIp: lastKnownIp!.getOrCrash(),
      yeelightDeviceId: yeelightDeviceId!.getOrCrash(),
      yeelightPort: yeelightPort!.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }
}
