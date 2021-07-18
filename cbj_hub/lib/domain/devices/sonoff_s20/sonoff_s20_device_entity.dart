import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_s20/sonoff_s20_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sonoff_s20_device_entity.freezed.dart';

/// Abstract smart sonoffS20 that exist inside a computer, the implementations will
/// be actual sonoffS20 like blinds lights and more
@freezed
abstract class SonoffS20DE implements _$SonoffS20DE, DeviceEntityAbstract {
  /// All public field of sonoffS20 entity
  const factory SonoffS20DE({
    /// The smart sonoffS20 id
    //
    required CoreUniqueId? id,

    /// The default name of the sonoffS20
    required DeviceDefaultName? defaultName,

    /// Room id that the smart sonoffS20 located in.
    required CoreUniqueId? roomId,

    /// Room name that the smart sonoffS20 located in.
    required DeviceRoomName? roomName,

    /// Did the massage arrived or was it just sent.
    /// Will be 'set' (need change) or 'ack' for acknowledge
    required DeviceState? deviceStateGRPC,

    /// If state didn't change the error description will be found here.
    DeviceStateMassage? stateMassage,

    /// Sender SonoffS20 os type, example: android, iphone, browser
    required DeviceSenderDeviceOs? senderDeviceOs,

    /// The sender SonoffS20 model, example: onePlus 3T
    required DeviceSenderDeviceModel? senderDeviceModel,

    /// Last SonoffS20 sender id that activated the action
    required DeviceSenderId? senderId,

    /// What action to execute
    required DeviceAction? deviceActions,

    /// The smart sonoffS20 type
    required DeviceType? deviceTypes,

    /// Unique id of the computer that the sonoffS20s located in
    required DeviceCompUuid? compUuid,

    /// Last known Ip of the computer that the sonoffS20 located in
    DeviceLastKnownIp? lastKnownIp,

    /// SonoffS20 power consumption in watts
    DevicePowerConsumption? powerConsumption,

    /// SonoffS20 mdns name
    DeviceMdnsName? deviceMdnsName,

    /// SonoffS20 second WiFi
    DeviceSecondWiFiName? deviceSecondWiFi,

    /// SonoffS20 key of the switch
    SonoffS20SwitchKey? sonoffS20SwitchKey,
  }) = _SonoffS20DE;

  const SonoffS20DE._();

  /// Empty instance of SonoffS20Entity
  factory SonoffS20DE.empty() => SonoffS20DE(
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
        sonoffS20SwitchKey: SonoffS20SwitchKey(''),
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
    return SonoffS20Dtos(
      deviceDtoClass: (SonoffS20Dtos).toString(),
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
      sonoffS20SwitchKey: sonoffS20SwitchKey!.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }
}
