import 'package:cbj_hub/domain/devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_entity.dart';
import 'package:cbj_hub/domain/devices/yeelight/yeelight_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/abstract_device/device_entity_dto_abstract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'yeelight_dtos.freezed.dart';
part 'yeelight_dtos.g.dart';

@freezed
abstract class YeelightDtos implements _$YeelightDtos, DeviceEntityDtoAbstract {
  factory YeelightDtos({
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
    required String yeelightDeviceId,
    required String yeelightPort,
    String? deviceSecondWiFi,
    String? deviceMdnsName,
    String? lastKnownIp,
    // required ServerTimestampConverter() FieldValue serverTimeStamp,
  }) = _YeelightDtos;

  YeelightDtos._();

  @override
  final String deviceDtoClassInstance = (YeelightDtos).toString();

  factory YeelightDtos.fromDomain(YeelightDE yeelightDE) {
    return YeelightDtos(
      deviceDtoClass: (YeelightDtos).toString(),
      id: yeelightDE.id!.getOrCrash(),
      defaultName: yeelightDE.defaultName!.getOrCrash(),
      roomId: yeelightDE.roomId!.getOrCrash(),
      roomName: yeelightDE.roomName!.getOrCrash(),
      deviceStateGRPC: yeelightDE.deviceStateGRPC!.getOrCrash(),
      stateMassage: yeelightDE.stateMassage!.getOrCrash(),
      senderDeviceOs: yeelightDE.senderDeviceOs!.getOrCrash(),
      senderDeviceModel: yeelightDE.senderDeviceModel!.getOrCrash(),
      senderId: yeelightDE.senderId!.getOrCrash(),
      deviceActions: yeelightDE.deviceActions!.getOrCrash(),
      deviceTypes: yeelightDE.deviceTypes!.getOrCrash(),
      compUuid: yeelightDE.compUuid!.getOrCrash(),
      deviceSecondWiFi: yeelightDE.deviceSecondWiFi!.getOrCrash(),
      deviceMdnsName: yeelightDE.deviceMdnsName!.getOrCrash(),
      lastKnownIp: yeelightDE.lastKnownIp!.getOrCrash(),
      yeelightDeviceId: yeelightDE.yeelightDeviceId!.getOrCrash(),
      yeelightPort: yeelightDE.yeelightPort!.getOrCrash(),
      // serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  factory YeelightDtos.fromJson(Map<String, dynamic> json) =>
      _$YeelightDtosFromJson(json);

  DeviceEntityAbstract toDomain() {
    print('YeelightDto to Domain');
    return YeelightDE(
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
      yeelightDeviceId: YeelightDeviceId(yeelightDeviceId),
      yeelightPort: YeelightPort(yeelightPort),
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
