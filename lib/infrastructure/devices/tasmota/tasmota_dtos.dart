import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/tasmota_device/tasmota_device_entity.dart';
import 'package:cbj_hub/domain/devices/tasmota_device/tasmota_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasmota_dtos.freezed.dart';
part 'tasmota_dtos.g.dart';

@freezed
abstract class TasmotaDtos implements _$TasmotaDtos, DeviceEntityDtoAbstract {
  factory TasmotaDtos({
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
    String? tasmotaSwitchKey,

    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _TasmotaDtos;

  TasmotaDtos._();

  @override
  final String deviceDtoClassInstance = (TasmotaDtos).toString();

  factory TasmotaDtos.fromDomain(TasmotaDE tasmotaDE) {
    return TasmotaDtos(
      deviceDtoClass: (TasmotaDtos).toString(),
      id: tasmotaDE.id!.getOrCrash(),
      defaultName: tasmotaDE.defaultName!.getOrCrash(),
      roomId: tasmotaDE.roomId!.getOrCrash(),
      roomName: tasmotaDE.roomName!.getOrCrash(),
      deviceStateGRPC: tasmotaDE.deviceStateGRPC!.getOrCrash(),
      stateMassage: tasmotaDE.stateMassage!.getOrCrash(),
      senderDeviceOs: tasmotaDE.senderDeviceOs!.getOrCrash(),
      senderDeviceModel: tasmotaDE.senderDeviceModel!.getOrCrash(),
      senderId: tasmotaDE.senderId!.getOrCrash(),
      deviceActions: tasmotaDE.deviceActions!.getOrCrash(),
      deviceTypes: tasmotaDE.deviceTypes!.getOrCrash(),
      compUuid: tasmotaDE.compUuid!.getOrCrash(),
      deviceSecondWiFi: tasmotaDE.deviceSecondWiFi!.getOrCrash(),
      deviceMdnsName: tasmotaDE.deviceMdnsName!.getOrCrash(),
      lastKnownIp: tasmotaDE.lastKnownIp!.getOrCrash(),
      tasmotaSwitchKey: tasmotaDE.tasmotaSwitchKey!.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory TasmotaDtos.fromJson(Map<String, dynamic> json) =>
      _$TasmotaDtosFromJson(json);

  DeviceEntityAbstract toDomain() {
    print('TasmotaDto to Domain');
    return TasmotaDE(
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
      tasmotaSwitchKey: TasmotaSwitchKey(tasmotaSwitchKey),
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
