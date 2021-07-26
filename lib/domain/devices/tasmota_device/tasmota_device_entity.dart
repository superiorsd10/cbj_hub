import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/tasmota_device/tasmota_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_dtos.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasmota_device_entity.freezed.dart';

/// Abstract smart Tasmota that exist inside a computer, the implementations
/// will be actual Tasmota like blinds lights and more
@freezed
abstract class TasmotaDE implements _$TasmotaDE, DeviceEntityAbstract {
  /// All public field of Tasmota entity
  const factory TasmotaDE({
    /// The smart Tasmota id
    //
    required CoreUniqueId? id,

    /// The default name of the Tasmota
    required DeviceDefaultName? defaultName,

    /// Room id that the smart Tasmota located in.
    required CoreUniqueId? roomId,

    /// Room name that the smart Tasmota located in.
    required DeviceRoomName? roomName,

    /// Did the massage arrived or was it just sent.
    /// Will be 'set' (need change) or 'ack' for acknowledge
    required DeviceState? deviceStateGRPC,

    /// If state didn't change the error description will be found here.
    DeviceStateMassage? stateMassage,

    /// Sender Tasmota os type, example: android, iphone, browser
    required DeviceSenderDeviceOs? senderDeviceOs,

    /// The sender Tasmota model, example: onePlus 3T
    required DeviceSenderDeviceModel? senderDeviceModel,

    /// Last Tasmota sender id that activated the action
    required DeviceSenderId? senderId,

    /// What action to execute
    required DeviceAction? deviceActions,

    /// The smart Tasmota type
    required DeviceType? deviceTypes,

    /// Unique id of the computer that the Tasmota located in
    required DeviceCompUuid? compUuid,

    /// Last known Ip of the computer that the Tasmota located in
    DeviceLastKnownIp? lastKnownIp,

    /// Tasmota power consumption in watts
    DevicePowerConsumption? powerConsumption,

    /// Tasmota mdns name
    DeviceMdnsName? deviceMdnsName,

    /// Tasmota second WiFi
    DeviceSecondWiFiName? deviceSecondWiFi,

    /// Tasmota key of the switch
    TasmotaSwitchKey? tasmotaSwitchKey,
  }) = _TasmotaDE;

  const TasmotaDE._();

  /// Empty instance of TasmotaEntity
  factory TasmotaDE.empty() => TasmotaDE(
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
        tasmotaSwitchKey: TasmotaSwitchKey(''),
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
    return TasmotaDtos(
      deviceDtoClass: (TasmotaDtos).toString(),
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
      tasmotaSwitchKey: tasmotaSwitchKey!.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }
}
