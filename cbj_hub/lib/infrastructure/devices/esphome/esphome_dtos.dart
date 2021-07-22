import 'package:cbj_hub/domain/device_type/device_type_enums.dart';
import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_entity.dart';
import 'package:cbj_hub/domain/devices/esphome_device/esphome_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'esphome_dtos.freezed.dart';

part 'esphome_dtos.g.dart';

@freezed
abstract class EspHomeDtos implements _$EspHomeDtos, DeviceEntityDtoAbstract {
  factory EspHomeDtos({
    // @JsonKey(ignore: true)
    String? deviceDtoClass,
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
    String? espHomeSwitchKey,

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _EspHomeDtos;

  EspHomeDtos._();

  @override
  final String deviceDtoClassInstance = (EspHomeDtos).toString();

  factory EspHomeDtos.fromDomain(ESPHomeDE espHomeDE) {
    return EspHomeDtos(
      deviceDtoClass: (EspHomeDtos).toString(),
      id: espHomeDE.id!.getOrCrash(),
      defaultName: espHomeDE.defaultName!.getOrCrash(),
      roomId: espHomeDE.roomId!.getOrCrash(),
      roomName: espHomeDE.roomName!.getOrCrash(),
      deviceStateGRPC: espHomeDE.deviceStateGRPC!.getOrCrash(),
      stateMassage: espHomeDE.stateMassage!.getOrCrash(),
      senderDeviceOs: espHomeDE.senderDeviceOs!.getOrCrash(),
      senderDeviceModel: espHomeDE.senderDeviceModel!.getOrCrash(),
      senderId: espHomeDE.senderId!.getOrCrash(),
      deviceActions: espHomeDE.deviceActions!.getOrCrash(),
      deviceTypes: espHomeDE.deviceTypes!.getOrCrash(),
      compUuid: espHomeDE.compUuid!.getOrCrash(),
      deviceSecondWiFi: espHomeDE.deviceSecondWiFi!.getOrCrash(),
      deviceMdnsName: espHomeDE.deviceMdnsName!.getOrCrash(),
      lastKnownIp: espHomeDE.lastKnownIp!.getOrCrash(),
      espHomeSwitchKey: espHomeDE.espHomeSwitchKey!.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory EspHomeDtos.fromJson(Map<String, dynamic> json) =>
      _$EspHomeDtosFromJson(json);

  DeviceEntityAbstract toDomain() {
    print('ESPHomeDto to Domain');
    return ESPHomeDE(
      id: CoreUniqueId.fromUniqueString(id),
      defaultName: DeviceDefaultName(defaultName),
      roomId: CoreUniqueId.fromUniqueString(roomId),
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
      espHomeSwitchKey: ESPHomeSwitchKey(espHomeSwitchKey),
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
