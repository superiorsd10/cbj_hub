import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/devices/basic_device/device_entity.dart';
import 'package:cbj_hub/domain/devices/basic_device/value_objects.dart';
import 'package:cbj_hub/domain/devices/sonoff_s20/sonoff_s20_device_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sonoff_s20_dtos.freezed.dart';
part 'sonoff_s20_dtos.g.dart';

@freezed
abstract class SonoffS20Dtos implements _$SonoffS20Dtos {
  const factory SonoffS20Dtos({
    // @JsonKey(ignore: true)
    String? id,
    required String? defaultName,
    required String? roomId,
    required String? roomName,
    required String? deviceStateGRPC,
    String? stateMassage,
    required String? senderDeviceOs,
    required String? senderDeviceModel,
    required String? senderId,
    required String? deviceActions,
    required String? deviceTypes,
    required String? compUuid,
    String? deviceSecondWiFi,
    String? deviceMdnsName,
    String? lastKnownIp,

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _SonoffS20Dtos;

  const SonoffS20Dtos._();

  factory SonoffS20Dtos.fromDomain(SonoffS20DE sonoffS20DE) {
    return SonoffS20Dtos(
      id: sonoffS20DE.id!.getOrCrash(),
      defaultName: sonoffS20DE.defaultName!.getOrCrash(),
      roomId: sonoffS20DE.roomId!.getOrCrash(),
      roomName: sonoffS20DE.roomName!.getOrCrash(),
      deviceStateGRPC: sonoffS20DE.deviceStateGRPC!.getOrCrash(),
      stateMassage: sonoffS20DE.stateMassage!.getOrCrash(),
      senderDeviceOs: sonoffS20DE.senderDeviceOs!.getOrCrash(),
      senderDeviceModel: sonoffS20DE.senderDeviceModel!.getOrCrash(),
      senderId: sonoffS20DE.senderId!.getOrCrash(),
      deviceActions: sonoffS20DE.deviceActions!.getOrCrash(),
      deviceTypes: sonoffS20DE.deviceTypes!.getOrCrash(),
      compUuid: sonoffS20DE.compUuid!.getOrCrash(),
      deviceSecondWiFi: sonoffS20DE.deviceSecondWiFi!.getOrCrash(),
      deviceMdnsName: sonoffS20DE.deviceMdnsName!.getOrCrash(),
      lastKnownIp: sonoffS20DE.lastKnownIp!.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory SonoffS20Dtos.fromJson(Map<String, dynamic> json) =>
      _$SonoffS20DtosFromJson(json);

  DeviceEntity toDomain() {
    return DeviceEntity(
      id: DeviceUniqueId.fromUniqueString(id),
      defaultName: DeviceDefaultName(defaultName),
      roomId: DeviceUniqueId.fromUniqueString(roomId),
      roomName: DeviceRoomName(roomName),
      deviceStateGRPC: DeviceState(deviceStateGRPC),
      stateMassage: DeviceStateMassage(stateMassage),
      senderDeviceOs: DeviceSenderDeviceOs(senderDeviceOs),
      senderDeviceModel: DeviceSenderDeviceModel(senderDeviceModel),
      senderId: DeviceSenderId.fromUniqueString(senderId),
      deviceActions: DeviceAction(deviceActions),
      deviceTypes: DeviceType(deviceTypes),
      compUuid: DeviceCompUuid(compUuid),
      deviceSecondWiFi: DeviceSecondWiFiName(deviceSecondWiFi),
      deviceMdnsName: DeviceMdnsName(deviceMdnsName),
      lastKnownIp: DeviceLastKnownIp(lastKnownIp),
    );
  }

  SmartDeviceInfo toSmartDeviceInfo() {
    return SmartDeviceInfo(
      id: id,
      defaultName: defaultName,
      roomId: roomId,
      state: deviceStateGRPC,
      senderDeviceOs: senderDeviceOs,
      senderDeviceModel: senderDeviceModel,
      senderId: senderId,
      deviceTypesActions: DeviceTypesActions(
        deviceStateGRPC: EnumHelper.stringToDeviceState(deviceStateGRPC!),
        deviceAction: EnumHelper.stringToDeviceAction(deviceActions!),
        deviceType: EnumHelper.stringToDt(deviceTypes!),
      ),
    );
  }
}

// class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
//   const ServerTimestampConverter();
//
//   @override
//   FieldValue fromJson(Object json) {
//     return FieldValue.serverTimestamp();
//   }
//
//   @override
//   Object toJson(FieldValue fieldValue) => fieldValue;
// }
