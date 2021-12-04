import 'package:cbj_hub/domain/rooms/rooms_failures.dart';
import 'package:cbj_hub/domain/rooms/value_objects_rooms.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/rooms/rooms_entity_dto_abstract.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class RoomsEntityAbstract {
  RoomsEntityAbstract({
    required this.uniqueId,
    required this.roomsVendor,
    required this.roomsTypes,
    required this.defaultName,
    required this.roomId,
    required this.roomName,
    required this.stateMassage,
    required this.senderRoomsOs,
    required this.senderRoomsModel,
    required this.senderId,
    required this.compUuid,
    required this.roomsStateGRPC,
  });

  RoomsUniqueId uniqueId;

  /// The default name of the GenericLight
  RoomsDefaultName defaultName;

  /// Room id that the smart GenericLight located in.
  RoomsUniqueId roomId;

  /// Room name that the smart GenericLight located in.
  RoomsRoomName roomName;

  /// Did the massage arrived or was it just sent.
  /// Will be 'set' (need change) or 'ack' for acknowledge
  RoomsState roomsStateGRPC;

  /// If state didn't change the error description will be found here.
  RoomsStateMassage stateMassage;

  /// Sender GenericLight os type, example: android, iphone, browser
  RoomsSenderRoomsOs senderRoomsOs;

  /// The sender GenericLight model; example: onePlus 3T
  RoomsSenderRoomsModel senderRoomsModel;

  /// Last GenericLight sender id that activated the action
  RoomsSenderId senderId;

  /// The smart GenericLight type
  RoomsType roomsTypes;

  /// The smart GenericLight type
  RoomsVendor roomsVendor;

  /// Unique id of the computer that the GenericLight located in
  RoomsCompUuid compUuid;

  String getRoomsId();

  RoomsEntityDtoAbstract toInfrastructure() {
    return RoomsEntityDtoAbstract();
  }

  /// Please override the following methods
  Future<Either<RoomsFailure, Unit>> executeRoomsAction({
    required RoomsEntityAbstract newEntity,
  });
}

class RoomsEntityNotAbstract extends RoomsEntityAbstract {
  RoomsEntityNotAbstract()
      : super(
          uniqueId: RoomsUniqueId(),
          roomsVendor: RoomsVendor(
            VendorsAndServices.vendorsAndServicesNotSupported.toString(),
          ),
          roomsStateGRPC: RoomsState(RoomsTypes.typeNotSupported.toString()),
          compUuid: RoomsCompUuid(const Uuid().v1().toString()),
          defaultName: RoomsDefaultName('No Name'),
          roomsTypes: RoomsType(RoomsTypes.light.toString()),
          roomId: RoomsUniqueId(),
          roomName: RoomsRoomName('No name'),
          senderRoomsModel: RoomsSenderRoomsModel('a'),
          senderRoomsOs: RoomsSenderRoomsOs('b'),
          senderId: RoomsSenderId(),
          stateMassage: RoomsStateMassage('go'),
        );

  @override
  RoomsEntityDtoAbstract toInfrastructure() {
    return RoomsEntityDtoAbstract();
  }

  @override
  String getRoomsId() {
    // TODO: implement getRoomsId
    throw UnimplementedError();
  }

  @override
  Future<Either<RoomsFailure, Unit>> executeRoomsAction({
    required RoomsEntityAbstract newEntity,
  }) {
    // TODO: implement executeRoomsAction
    throw UnimplementedError();
  }

  /// The smart rooms id
// RoomsUniqueId? id;
//
// /// The default name of the rooms
// RoomsDefaultName? defaultName;
}

//
// part 'rooms_entity_abstract.freezed.dart';
//
// /// Abstract smart rooms that exist inside a computer, the implementations will
// /// be actual rooms like blinds lights and more
// @freezed
// abstract class RoomsEntityAbstract implements _$RoomsEntityAbstract {
//   /// All public field of rooms entity
//   const factory RoomsEntityAbstract({
//     /// The smart rooms id
//     required RoomsUniqueId? id,
//
//     /// The default name of the rooms
//     required RoomsDefaultName? defaultName,
//   }) = _RoomsEntityAbstract;
//
//   const RoomsEntityAbstract._();
//
//   /// Empty instance of RoomsEntity
//   factory RoomsEntityAbstract.empty() => RoomsEntityAbstract(
//         id: RoomsUniqueId(),
//         defaultName: RoomsDefaultName(''),
//       );
//
//   /// Will return failure if any of the fields failed or return unit if fields
//   /// have legit values
//   Option<RoomsFailure<dynamic>> get failureOption {
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
