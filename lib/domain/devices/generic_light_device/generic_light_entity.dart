import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/generic_light_device/generic_light_device_dtos.dart';

/// Abstract smart GenericLight that exist inside a computer, the
/// implementations will be actual GenericLight like blinds lights and more
class GenericLightDE extends DeviceEntityAbstract {
  /// All public field of GenericLight entity
  GenericLightDE({
    required this.uniqueId,
    required this.defaultName,
    required this.roomId,
    required this.roomName,
    required this.deviceStateGRPC,
    required this.stateMassage,
    required this.senderDeviceOs,
    required this.senderDeviceModel,
    required this.senderId,
    required this.deviceActions,
    required this.deviceTypes,
    required this.deviceVendor,
    required this.compUuid,
    required this.lastKnownIp,
    this.powerConsumption,
    this.deviceMdnsName,
    this.deviceSecondWiFi,
    this.genericLightSwitchKey,
  });

  /// The smart GenericLight id
  CoreUniqueId? uniqueId;

  /// The default name of the GenericLight
  DeviceDefaultName? defaultName;

  /// Room id that the smart GenericLight located in.
  CoreUniqueId? roomId;

  /// Room name that the smart GenericLight located in.
  DeviceRoomName? roomName;

  /// Did the massage arrived or was it just sent.
  /// Will be 'set' (need change) or 'ack' for acknowledge
  DeviceState? deviceStateGRPC;

  /// If state didn't change the error description will be found here.
  DeviceStateMassage? stateMassage;

  /// Sender GenericLight os type, example: android, iphone, browser
  DeviceSenderDeviceOs? senderDeviceOs;

  /// The sender GenericLight model; example: onePlus 3T
  DeviceSenderDeviceModel? senderDeviceModel;

  /// Last GenericLight sender id that activated the action
  DeviceSenderId? senderId;

  /// What action to execute
  DeviceAction? deviceActions;

  /// The smart GenericLight type
  DeviceType? deviceTypes;

  /// The smart GenericLight type
  DeviceVendor? deviceVendor;

  /// Unique id of the computer that the GenericLight located in
  DeviceCompUuid? compUuid;

  /// Last known Ip of the computer that the GenericLight located in
  DeviceLastKnownIp? lastKnownIp;

  /// GenericLight power consumption in watts
  DevicePowerConsumption? powerConsumption;

  /// GenericLight mdns name
  DeviceMdnsName? deviceMdnsName;

  /// GenericLight second WiFi
  DeviceSecondWiFiName? deviceSecondWiFi;

  /// GenericLight key of the switch
  GenericLightSwitchKey? genericLightSwitchKey;

  /// Empty instance of GenericLightEntity
  factory GenericLightDE.empty() => GenericLightDE(
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
        deviceVendor: DeviceVendor(''),
        deviceTypes: DeviceType(''),
        compUuid: DeviceCompUuid(''),
        lastKnownIp: DeviceLastKnownIp(''),
        genericLightSwitchKey: GenericLightSwitchKey(''),
      );

  //
  // /// Will return failure if any of the fields failed or return unit if fields
  // /// have legit values
  // Option<CoreFailure<dynamic>> get failureOption {
  //   return defaultName!.value.fold((f) => some(f), (_) => none());
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
  // }

  @override
  String getDeviceId() {
    return uniqueId!.getOrCrash()!;
  }

  @override
  DeviceEntityDtoAbstract toInfrastructure() {
    return GenericLightDeviceDtos(
      deviceDtoClass: (GenericLightDeviceDtos).toString(),
      id: uniqueId!.getOrCrash(),
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
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }
}
