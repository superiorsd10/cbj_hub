// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'device_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DeviceEntityTearOff {
  const _$DeviceEntityTearOff();

  _DeviceEnitie call(
      {required DeviceUniqueId? id,
      required DeviceDefaultName? defaultName,
      required DeviceUniqueId? roomId,
      required DeviceRoomName? roomName,
      required DeviceState? deviceStateGRPC,
      DeviceStateMassage? stateMassage,
      required DeviceSenderDeviceOs? senderDeviceOs,
      required DeviceSenderDeviceModel? senderDeviceModel,
      required DeviceSenderId? senderId,
      required DeviceAction? deviceActions,
      required DeviceType? deviceTypes,
      required DeviceCompUuid? compUuid,
      DeviceLastKnownIp? lastKnownIp,
      DevicePowerConsumption? powerConsumption,
      DeviceMdnsName? deviceMdnsName,
      DeviceSecondWiFiName? deviceSecondWiFi}) {
    return _DeviceEnitie(
      id: id,
      defaultName: defaultName,
      roomId: roomId,
      roomName: roomName,
      deviceStateGRPC: deviceStateGRPC,
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
  }
}

/// @nodoc
const $DeviceEntity = _$DeviceEntityTearOff();

/// @nodoc
mixin _$DeviceEntity {
  /// The smart device id
  DeviceUniqueId? get id => throw _privateConstructorUsedError;

  /// The default name of the device
  DeviceDefaultName? get defaultName => throw _privateConstructorUsedError;

  /// Room id that the smart device located in.
  DeviceUniqueId? get roomId => throw _privateConstructorUsedError;

  /// Room name that the smart device located in.
  DeviceRoomName? get roomName => throw _privateConstructorUsedError;

  /// Did the massage arrived or was it just sent.
  /// Will be 'set' (need change) or 'ack' for acknowledge
  DeviceState? get deviceStateGRPC => throw _privateConstructorUsedError;

  /// If state didn't change the error description will be found here.
  DeviceStateMassage? get stateMassage => throw _privateConstructorUsedError;

  /// Sender device os type, example: android, iphone, browser
  DeviceSenderDeviceOs? get senderDeviceOs =>
      throw _privateConstructorUsedError;

  /// The sender device model, example: onePlus 3T
  DeviceSenderDeviceModel? get senderDeviceModel =>
      throw _privateConstructorUsedError;

  /// Last device sender id that activated the action
  DeviceSenderId? get senderId => throw _privateConstructorUsedError;

  /// What action to execute
  DeviceAction? get deviceActions => throw _privateConstructorUsedError;

  /// The smart device type
  DeviceType? get deviceTypes => throw _privateConstructorUsedError;

  /// Unique id of the computer that the devices located in
  DeviceCompUuid? get compUuid => throw _privateConstructorUsedError;

  /// Last known Ip of the computer that the device located in
  DeviceLastKnownIp? get lastKnownIp => throw _privateConstructorUsedError;

  /// Device power consumption in watts
  DevicePowerConsumption? get powerConsumption =>
      throw _privateConstructorUsedError;

  /// Device mdns name
  DeviceMdnsName? get deviceMdnsName => throw _privateConstructorUsedError;

  /// Device second WiFi
  DeviceSecondWiFiName? get deviceSecondWiFi =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceEntityCopyWith<DeviceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceEntityCopyWith<$Res> {
  factory $DeviceEntityCopyWith(
          DeviceEntity value, $Res Function(DeviceEntity) then) =
      _$DeviceEntityCopyWithImpl<$Res>;
  $Res call(
      {DeviceUniqueId? id,
      DeviceDefaultName? defaultName,
      DeviceUniqueId? roomId,
      DeviceRoomName? roomName,
      DeviceState? deviceStateGRPC,
      DeviceStateMassage? stateMassage,
      DeviceSenderDeviceOs? senderDeviceOs,
      DeviceSenderDeviceModel? senderDeviceModel,
      DeviceSenderId? senderId,
      DeviceAction? deviceActions,
      DeviceType? deviceTypes,
      DeviceCompUuid? compUuid,
      DeviceLastKnownIp? lastKnownIp,
      DevicePowerConsumption? powerConsumption,
      DeviceMdnsName? deviceMdnsName,
      DeviceSecondWiFiName? deviceSecondWiFi});
}

/// @nodoc
class _$DeviceEntityCopyWithImpl<$Res> implements $DeviceEntityCopyWith<$Res> {
  _$DeviceEntityCopyWithImpl(this._value, this._then);

  final DeviceEntity _value;
  // ignore: unused_field
  final $Res Function(DeviceEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? defaultName = freezed,
    Object? roomId = freezed,
    Object? roomName = freezed,
    Object? deviceStateGRPC = freezed,
    Object? stateMassage = freezed,
    Object? senderDeviceOs = freezed,
    Object? senderDeviceModel = freezed,
    Object? senderId = freezed,
    Object? deviceActions = freezed,
    Object? deviceTypes = freezed,
    Object? compUuid = freezed,
    Object? lastKnownIp = freezed,
    Object? powerConsumption = freezed,
    Object? deviceMdnsName = freezed,
    Object? deviceSecondWiFi = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DeviceUniqueId?,
      defaultName: defaultName == freezed
          ? _value.defaultName
          : defaultName // ignore: cast_nullable_to_non_nullable
              as DeviceDefaultName?,
      roomId: roomId == freezed
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as DeviceUniqueId?,
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as DeviceRoomName?,
      deviceStateGRPC: deviceStateGRPC == freezed
          ? _value.deviceStateGRPC
          : deviceStateGRPC // ignore: cast_nullable_to_non_nullable
              as DeviceState?,
      stateMassage: stateMassage == freezed
          ? _value.stateMassage
          : stateMassage // ignore: cast_nullable_to_non_nullable
              as DeviceStateMassage?,
      senderDeviceOs: senderDeviceOs == freezed
          ? _value.senderDeviceOs
          : senderDeviceOs // ignore: cast_nullable_to_non_nullable
              as DeviceSenderDeviceOs?,
      senderDeviceModel: senderDeviceModel == freezed
          ? _value.senderDeviceModel
          : senderDeviceModel // ignore: cast_nullable_to_non_nullable
              as DeviceSenderDeviceModel?,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as DeviceSenderId?,
      deviceActions: deviceActions == freezed
          ? _value.deviceActions
          : deviceActions // ignore: cast_nullable_to_non_nullable
              as DeviceAction?,
      deviceTypes: deviceTypes == freezed
          ? _value.deviceTypes
          : deviceTypes // ignore: cast_nullable_to_non_nullable
              as DeviceType?,
      compUuid: compUuid == freezed
          ? _value.compUuid
          : compUuid // ignore: cast_nullable_to_non_nullable
              as DeviceCompUuid?,
      lastKnownIp: lastKnownIp == freezed
          ? _value.lastKnownIp
          : lastKnownIp // ignore: cast_nullable_to_non_nullable
              as DeviceLastKnownIp?,
      powerConsumption: powerConsumption == freezed
          ? _value.powerConsumption
          : powerConsumption // ignore: cast_nullable_to_non_nullable
              as DevicePowerConsumption?,
      deviceMdnsName: deviceMdnsName == freezed
          ? _value.deviceMdnsName
          : deviceMdnsName // ignore: cast_nullable_to_non_nullable
              as DeviceMdnsName?,
      deviceSecondWiFi: deviceSecondWiFi == freezed
          ? _value.deviceSecondWiFi
          : deviceSecondWiFi // ignore: cast_nullable_to_non_nullable
              as DeviceSecondWiFiName?,
    ));
  }
}

/// @nodoc
abstract class _$DeviceEnitieCopyWith<$Res>
    implements $DeviceEntityCopyWith<$Res> {
  factory _$DeviceEnitieCopyWith(
          _DeviceEnitie value, $Res Function(_DeviceEnitie) then) =
      __$DeviceEnitieCopyWithImpl<$Res>;
  @override
  $Res call(
      {DeviceUniqueId? id,
      DeviceDefaultName? defaultName,
      DeviceUniqueId? roomId,
      DeviceRoomName? roomName,
      DeviceState? deviceStateGRPC,
      DeviceStateMassage? stateMassage,
      DeviceSenderDeviceOs? senderDeviceOs,
      DeviceSenderDeviceModel? senderDeviceModel,
      DeviceSenderId? senderId,
      DeviceAction? deviceActions,
      DeviceType? deviceTypes,
      DeviceCompUuid? compUuid,
      DeviceLastKnownIp? lastKnownIp,
      DevicePowerConsumption? powerConsumption,
      DeviceMdnsName? deviceMdnsName,
      DeviceSecondWiFiName? deviceSecondWiFi});
}

/// @nodoc
class __$DeviceEnitieCopyWithImpl<$Res> extends _$DeviceEntityCopyWithImpl<$Res>
    implements _$DeviceEnitieCopyWith<$Res> {
  __$DeviceEnitieCopyWithImpl(
      _DeviceEnitie _value, $Res Function(_DeviceEnitie) _then)
      : super(_value, (v) => _then(v as _DeviceEnitie));

  @override
  _DeviceEnitie get _value => super._value as _DeviceEnitie;

  @override
  $Res call({
    Object? id = freezed,
    Object? defaultName = freezed,
    Object? roomId = freezed,
    Object? roomName = freezed,
    Object? deviceStateGRPC = freezed,
    Object? stateMassage = freezed,
    Object? senderDeviceOs = freezed,
    Object? senderDeviceModel = freezed,
    Object? senderId = freezed,
    Object? deviceActions = freezed,
    Object? deviceTypes = freezed,
    Object? compUuid = freezed,
    Object? lastKnownIp = freezed,
    Object? powerConsumption = freezed,
    Object? deviceMdnsName = freezed,
    Object? deviceSecondWiFi = freezed,
  }) {
    return _then(_DeviceEnitie(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as DeviceUniqueId?,
      defaultName: defaultName == freezed
          ? _value.defaultName
          : defaultName // ignore: cast_nullable_to_non_nullable
              as DeviceDefaultName?,
      roomId: roomId == freezed
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as DeviceUniqueId?,
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as DeviceRoomName?,
      deviceStateGRPC: deviceStateGRPC == freezed
          ? _value.deviceStateGRPC
          : deviceStateGRPC // ignore: cast_nullable_to_non_nullable
              as DeviceState?,
      stateMassage: stateMassage == freezed
          ? _value.stateMassage
          : stateMassage // ignore: cast_nullable_to_non_nullable
              as DeviceStateMassage?,
      senderDeviceOs: senderDeviceOs == freezed
          ? _value.senderDeviceOs
          : senderDeviceOs // ignore: cast_nullable_to_non_nullable
              as DeviceSenderDeviceOs?,
      senderDeviceModel: senderDeviceModel == freezed
          ? _value.senderDeviceModel
          : senderDeviceModel // ignore: cast_nullable_to_non_nullable
              as DeviceSenderDeviceModel?,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as DeviceSenderId?,
      deviceActions: deviceActions == freezed
          ? _value.deviceActions
          : deviceActions // ignore: cast_nullable_to_non_nullable
              as DeviceAction?,
      deviceTypes: deviceTypes == freezed
          ? _value.deviceTypes
          : deviceTypes // ignore: cast_nullable_to_non_nullable
              as DeviceType?,
      compUuid: compUuid == freezed
          ? _value.compUuid
          : compUuid // ignore: cast_nullable_to_non_nullable
              as DeviceCompUuid?,
      lastKnownIp: lastKnownIp == freezed
          ? _value.lastKnownIp
          : lastKnownIp // ignore: cast_nullable_to_non_nullable
              as DeviceLastKnownIp?,
      powerConsumption: powerConsumption == freezed
          ? _value.powerConsumption
          : powerConsumption // ignore: cast_nullable_to_non_nullable
              as DevicePowerConsumption?,
      deviceMdnsName: deviceMdnsName == freezed
          ? _value.deviceMdnsName
          : deviceMdnsName // ignore: cast_nullable_to_non_nullable
              as DeviceMdnsName?,
      deviceSecondWiFi: deviceSecondWiFi == freezed
          ? _value.deviceSecondWiFi
          : deviceSecondWiFi // ignore: cast_nullable_to_non_nullable
              as DeviceSecondWiFiName?,
    ));
  }
}

/// @nodoc

class _$_DeviceEnitie extends _DeviceEnitie {
  const _$_DeviceEnitie(
      {required this.id,
      required this.defaultName,
      required this.roomId,
      required this.roomName,
      required this.deviceStateGRPC,
      this.stateMassage,
      required this.senderDeviceOs,
      required this.senderDeviceModel,
      required this.senderId,
      required this.deviceActions,
      required this.deviceTypes,
      required this.compUuid,
      this.lastKnownIp,
      this.powerConsumption,
      this.deviceMdnsName,
      this.deviceSecondWiFi})
      : super._();

  @override

  /// The smart device id
  final DeviceUniqueId? id;
  @override

  /// The default name of the device
  final DeviceDefaultName? defaultName;
  @override

  /// Room id that the smart device located in.
  final DeviceUniqueId? roomId;
  @override

  /// Room name that the smart device located in.
  final DeviceRoomName? roomName;
  @override

  /// Did the massage arrived or was it just sent.
  /// Will be 'set' (need change) or 'ack' for acknowledge
  final DeviceState? deviceStateGRPC;
  @override

  /// If state didn't change the error description will be found here.
  final DeviceStateMassage? stateMassage;
  @override

  /// Sender device os type, example: android, iphone, browser
  final DeviceSenderDeviceOs? senderDeviceOs;
  @override

  /// The sender device model, example: onePlus 3T
  final DeviceSenderDeviceModel? senderDeviceModel;
  @override

  /// Last device sender id that activated the action
  final DeviceSenderId? senderId;
  @override

  /// What action to execute
  final DeviceAction? deviceActions;
  @override

  /// The smart device type
  final DeviceType? deviceTypes;
  @override

  /// Unique id of the computer that the devices located in
  final DeviceCompUuid? compUuid;
  @override

  /// Last known Ip of the computer that the device located in
  final DeviceLastKnownIp? lastKnownIp;
  @override

  /// Device power consumption in watts
  final DevicePowerConsumption? powerConsumption;
  @override

  /// Device mdns name
  final DeviceMdnsName? deviceMdnsName;
  @override

  /// Device second WiFi
  final DeviceSecondWiFiName? deviceSecondWiFi;

  @override
  String toString() {
    return 'DeviceEntity(id: $id, defaultName: $defaultName, roomId: $roomId, roomName: $roomName, deviceStateGRPC: $deviceStateGRPC, stateMassage: $stateMassage, senderDeviceOs: $senderDeviceOs, senderDeviceModel: $senderDeviceModel, senderId: $senderId, deviceActions: $deviceActions, deviceTypes: $deviceTypes, compUuid: $compUuid, lastKnownIp: $lastKnownIp, powerConsumption: $powerConsumption, deviceMdnsName: $deviceMdnsName, deviceSecondWiFi: $deviceSecondWiFi)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DeviceEnitie &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.defaultName, defaultName) ||
                const DeepCollectionEquality()
                    .equals(other.defaultName, defaultName)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.roomName, roomName) ||
                const DeepCollectionEquality()
                    .equals(other.roomName, roomName)) &&
            (identical(other.deviceStateGRPC, deviceStateGRPC) ||
                const DeepCollectionEquality()
                    .equals(other.deviceStateGRPC, deviceStateGRPC)) &&
            (identical(other.stateMassage, stateMassage) ||
                const DeepCollectionEquality()
                    .equals(other.stateMassage, stateMassage)) &&
            (identical(other.senderDeviceOs, senderDeviceOs) ||
                const DeepCollectionEquality()
                    .equals(other.senderDeviceOs, senderDeviceOs)) &&
            (identical(other.senderDeviceModel, senderDeviceModel) ||
                const DeepCollectionEquality()
                    .equals(other.senderDeviceModel, senderDeviceModel)) &&
            (identical(other.senderId, senderId) ||
                const DeepCollectionEquality()
                    .equals(other.senderId, senderId)) &&
            (identical(other.deviceActions, deviceActions) ||
                const DeepCollectionEquality()
                    .equals(other.deviceActions, deviceActions)) &&
            (identical(other.deviceTypes, deviceTypes) ||
                const DeepCollectionEquality()
                    .equals(other.deviceTypes, deviceTypes)) &&
            (identical(other.compUuid, compUuid) ||
                const DeepCollectionEquality()
                    .equals(other.compUuid, compUuid)) &&
            (identical(other.lastKnownIp, lastKnownIp) ||
                const DeepCollectionEquality()
                    .equals(other.lastKnownIp, lastKnownIp)) &&
            (identical(other.powerConsumption, powerConsumption) ||
                const DeepCollectionEquality()
                    .equals(other.powerConsumption, powerConsumption)) &&
            (identical(other.deviceMdnsName, deviceMdnsName) ||
                const DeepCollectionEquality()
                    .equals(other.deviceMdnsName, deviceMdnsName)) &&
            (identical(other.deviceSecondWiFi, deviceSecondWiFi) ||
                const DeepCollectionEquality()
                    .equals(other.deviceSecondWiFi, deviceSecondWiFi)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(defaultName) ^
      const DeepCollectionEquality().hash(roomId) ^
      const DeepCollectionEquality().hash(roomName) ^
      const DeepCollectionEquality().hash(deviceStateGRPC) ^
      const DeepCollectionEquality().hash(stateMassage) ^
      const DeepCollectionEquality().hash(senderDeviceOs) ^
      const DeepCollectionEquality().hash(senderDeviceModel) ^
      const DeepCollectionEquality().hash(senderId) ^
      const DeepCollectionEquality().hash(deviceActions) ^
      const DeepCollectionEquality().hash(deviceTypes) ^
      const DeepCollectionEquality().hash(compUuid) ^
      const DeepCollectionEquality().hash(lastKnownIp) ^
      const DeepCollectionEquality().hash(powerConsumption) ^
      const DeepCollectionEquality().hash(deviceMdnsName) ^
      const DeepCollectionEquality().hash(deviceSecondWiFi);

  @JsonKey(ignore: true)
  @override
  _$DeviceEnitieCopyWith<_DeviceEnitie> get copyWith =>
      __$DeviceEnitieCopyWithImpl<_DeviceEnitie>(this, _$identity);
}

abstract class _DeviceEnitie extends DeviceEntity {
  const factory _DeviceEnitie(
      {required DeviceUniqueId? id,
      required DeviceDefaultName? defaultName,
      required DeviceUniqueId? roomId,
      required DeviceRoomName? roomName,
      required DeviceState? deviceStateGRPC,
      DeviceStateMassage? stateMassage,
      required DeviceSenderDeviceOs? senderDeviceOs,
      required DeviceSenderDeviceModel? senderDeviceModel,
      required DeviceSenderId? senderId,
      required DeviceAction? deviceActions,
      required DeviceType? deviceTypes,
      required DeviceCompUuid? compUuid,
      DeviceLastKnownIp? lastKnownIp,
      DevicePowerConsumption? powerConsumption,
      DeviceMdnsName? deviceMdnsName,
      DeviceSecondWiFiName? deviceSecondWiFi}) = _$_DeviceEnitie;
  const _DeviceEnitie._() : super._();

  @override

  /// The smart device id
  DeviceUniqueId? get id => throw _privateConstructorUsedError;
  @override

  /// The default name of the device
  DeviceDefaultName? get defaultName => throw _privateConstructorUsedError;
  @override

  /// Room id that the smart device located in.
  DeviceUniqueId? get roomId => throw _privateConstructorUsedError;
  @override

  /// Room name that the smart device located in.
  DeviceRoomName? get roomName => throw _privateConstructorUsedError;
  @override

  /// Did the massage arrived or was it just sent.
  /// Will be 'set' (need change) or 'ack' for acknowledge
  DeviceState? get deviceStateGRPC => throw _privateConstructorUsedError;
  @override

  /// If state didn't change the error description will be found here.
  DeviceStateMassage? get stateMassage => throw _privateConstructorUsedError;
  @override

  /// Sender device os type, example: android, iphone, browser
  DeviceSenderDeviceOs? get senderDeviceOs =>
      throw _privateConstructorUsedError;
  @override

  /// The sender device model, example: onePlus 3T
  DeviceSenderDeviceModel? get senderDeviceModel =>
      throw _privateConstructorUsedError;
  @override

  /// Last device sender id that activated the action
  DeviceSenderId? get senderId => throw _privateConstructorUsedError;
  @override

  /// What action to execute
  DeviceAction? get deviceActions => throw _privateConstructorUsedError;
  @override

  /// The smart device type
  DeviceType? get deviceTypes => throw _privateConstructorUsedError;
  @override

  /// Unique id of the computer that the devices located in
  DeviceCompUuid? get compUuid => throw _privateConstructorUsedError;
  @override

  /// Last known Ip of the computer that the device located in
  DeviceLastKnownIp? get lastKnownIp => throw _privateConstructorUsedError;
  @override

  /// Device power consumption in watts
  DevicePowerConsumption? get powerConsumption =>
      throw _privateConstructorUsedError;
  @override

  /// Device mdns name
  DeviceMdnsName? get deviceMdnsName => throw _privateConstructorUsedError;
  @override

  /// Device second WiFi
  DeviceSecondWiFiName? get deviceSecondWiFi =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DeviceEnitieCopyWith<_DeviceEnitie> get copyWith =>
      throw _privateConstructorUsedError;
}
