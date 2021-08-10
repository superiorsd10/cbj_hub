import 'package:cbj_hub/domain/devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_value_objects.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';

/// Abstract smart ESPHome that exist inside a computer, the implementations
/// will be actual ESPHome like blinds lights and more
class ESPHomeDE extends GenericLightDE {
  ESPHomeDE({
    required CoreUniqueId uniqueId,

    /// Room id that the smart ESPHome located in.
    required CoreUniqueId roomId,

    /// The smart ESPHome type
    required DeviceType deviceTypes,

    /// The default name of the ESPHome
    DeviceDefaultName? defaultName,

    /// Room name that the smart ESPHome located in.
    DeviceRoomName? roomName,

    /// Did the massage arrived or was it just sent.
    /// Will be 'set' (need change) or 'ack' for acknowledge
    DeviceState? deviceStateGRPC,

    /// If state didn't change the error description will be found here.
    DeviceStateMassage? stateMassage,

    /// Sender ESPHome os type, example: android, iphone, browser
    DeviceSenderDeviceOs? senderDeviceOs,

    /// The sender ESPHome model, example: onePlus 3T
    DeviceSenderDeviceModel? senderDeviceModel,

    /// Last ESPHome sender id that activated the action
    DeviceSenderId? senderId,

    /// What action to execute
    DeviceAction? deviceActions,

    /// Unique id of the computer that the ESPHome located in
    DeviceCompUuid? compUuid,

    /// Last known Ip of the computer that the ESPHome located in
    DeviceLastKnownIp? lastKnownIp,

    /// ESPHome power consumption in watts
    DevicePowerConsumption? powerConsumption,

    /// ESPHome mdns name
    DeviceMdnsName? deviceMdnsName,

    /// ESPHome second WiFi
    DeviceSecondWiFiName? deviceSecondWiFi,

    /// ESPHome key of the switch
    ESPHomeSwitchKey? espHomeSwitchKey,
  }) : super(
          uniqueId: uniqueId,
          defaultName: defaultName,
          roomId: roomId,
          deviceVendor: DeviceVendor(VendorsAndServices.yeelight.toString()),
          deviceStateGRPC: deviceStateGRPC,
          roomName: roomName,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceActions: deviceActions,
          deviceTypes: deviceTypes,
          compUuid: compUuid,
          lastKnownIp: lastKnownIp,
          powerConsumption: powerConsumption,
          deviceMdnsName: deviceMdnsName,
          deviceSecondWiFi: deviceSecondWiFi,
        );

  /// ESPHome key of the switch
  ESPHomeSwitchKey? espHomeSwitchKey;

  /// Empty instance of ESPHomeEntity
  factory ESPHomeDE.empty() => ESPHomeDE(
        uniqueId: CoreUniqueId(),
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
        espHomeSwitchKey: ESPHomeSwitchKey(''),
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
    return uniqueId.getOrCrash()!;
  }
}
