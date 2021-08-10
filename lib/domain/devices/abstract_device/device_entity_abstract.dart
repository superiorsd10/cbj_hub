import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';

abstract class DeviceEntityAbstract {
  DeviceEntityAbstract(
      {required this.uniqueId,
      this.defaultName,
      this.roomId,
      this.deviceTypes});

  /// The smart GenericLight id
  CoreUniqueId uniqueId;

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

  String getDeviceId();

  DeviceEntityDtoAbstract toInfrastructure() {
    return DeviceEntityDtoAbstract();
  }
}

class DeviceEntityNotAbstract extends DeviceEntityAbstract {
  DeviceEntityNotAbstract({required CoreUniqueId uniqueId})
      : super(uniqueId: uniqueId);

  DeviceEntityDtoAbstract toInfrastructure() {
    return DeviceEntityDtoAbstract();
  }

  @override
  String getDeviceId() {
    // TODO: implement getDeviceId
    throw UnimplementedError();
  }

  /// The smart device id
// DeviceUniqueId? id;
//
// /// The default name of the device
// DeviceDefaultName? defaultName;
}

//
// part 'device_entity_abstract.freezed.dart';
//
// /// Abstract smart device that exist inside a computer, the implementations will
// /// be actual device like blinds lights and more
// @freezed
// abstract class DeviceEntityAbstract implements _$DeviceEntityAbstract {
//   /// All public field of device entity
//   const factory DeviceEntityAbstract({
//     /// The smart device id
//     required DeviceUniqueId? id,
//
//     /// The default name of the device
//     required DeviceDefaultName? defaultName,
//   }) = _DeviceEntityAbstract;
//
//   const DeviceEntityAbstract._();
//
//   /// Empty instance of DeviceEntity
//   factory DeviceEntityAbstract.empty() => DeviceEntityAbstract(
//         id: DeviceUniqueId(),
//         defaultName: DeviceDefaultName(''),
//       );
//
//   /// Will return failure if any of the fields failed or return unit if fields
//   /// have legit values
//   Option<DevicesFailure<dynamic>> get failureOption {
//     return defaultName!.value.fold((f) => some(f), (_) => none());
//     //
//     // return body.failureOrUnit
//     //     .andThen(todos.failureOrUnit)
//     //     .andThen(
//     //       todos
//     //           .getOrCrash()
//     //           // Getting the failureOption from the TodoItem ENTITY - NOT a failureOrUnit from a VALUE OBJECT
//     //           .map((todoItem) => todoItem.failureOption)
//     //           .filter((o) => o.isSome())
//     //           // If we can't get the 0th element, the list is empty. In such a case, it's valid.
//     //           .getOrElse(0, (_) => none())
//     //           .fold(() => right(unit), (f) => left(f)),
//     //     )
//     //     .fold((f) => some(f), (_) => none());
//   }
// }
