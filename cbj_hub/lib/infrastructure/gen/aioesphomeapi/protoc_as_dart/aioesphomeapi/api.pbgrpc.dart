///
//  Generated code. Do not modify.
//  source: aioesphomeapi/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'api.pb.dart' as $0;
import 'api_options.pb.dart' as $1;
export 'api.pb.dart';

class APIConnectionClient extends $grpc.Client {
  static final _$hello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloResponse>(
      '/APIConnection/hello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloResponse.fromBuffer(value));
  static final _$connect =
      $grpc.ClientMethod<$0.ConnectRequest, $0.ConnectResponse>(
          '/APIConnection/connect',
          ($0.ConnectRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ConnectResponse.fromBuffer(value));
  static final _$disconnect =
      $grpc.ClientMethod<$0.DisconnectRequest, $0.DisconnectResponse>(
          '/APIConnection/disconnect',
          ($0.DisconnectRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DisconnectResponse.fromBuffer(value));
  static final _$ping = $grpc.ClientMethod<$0.PingRequest, $0.PingResponse>(
      '/APIConnection/ping',
      ($0.PingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PingResponse.fromBuffer(value));
  static final _$device_info =
      $grpc.ClientMethod<$0.DeviceInfoRequest, $0.DeviceInfoResponse>(
          '/APIConnection/device_info',
          ($0.DeviceInfoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeviceInfoResponse.fromBuffer(value));
  static final _$list_entities =
      $grpc.ClientMethod<$0.ListEntitiesRequest, $1.void_>(
          '/APIConnection/list_entities',
          ($0.ListEntitiesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$subscribe_states =
      $grpc.ClientMethod<$0.SubscribeStatesRequest, $1.void_>(
          '/APIConnection/subscribe_states',
          ($0.SubscribeStatesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$subscribe_logs =
      $grpc.ClientMethod<$0.SubscribeLogsRequest, $1.void_>(
          '/APIConnection/subscribe_logs',
          ($0.SubscribeLogsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$subscribe_homeassistant_services =
      $grpc.ClientMethod<$0.SubscribeHomeassistantServicesRequest, $1.void_>(
          '/APIConnection/subscribe_homeassistant_services',
          ($0.SubscribeHomeassistantServicesRequest value) =>
              value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$subscribe_home_assistant_states =
      $grpc.ClientMethod<$0.SubscribeHomeAssistantStatesRequest, $1.void_>(
          '/APIConnection/subscribe_home_assistant_states',
          ($0.SubscribeHomeAssistantStatesRequest value) =>
              value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$get_time =
      $grpc.ClientMethod<$0.GetTimeRequest, $0.GetTimeResponse>(
          '/APIConnection/get_time',
          ($0.GetTimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetTimeResponse.fromBuffer(value));
  static final _$execute_service =
      $grpc.ClientMethod<$0.ExecuteServiceRequest, $1.void_>(
          '/APIConnection/execute_service',
          ($0.ExecuteServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$cover_command =
      $grpc.ClientMethod<$0.CoverCommandRequest, $1.void_>(
          '/APIConnection/cover_command',
          ($0.CoverCommandRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$fan_command =
      $grpc.ClientMethod<$0.FanCommandRequest, $1.void_>(
          '/APIConnection/fan_command',
          ($0.FanCommandRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$light_command =
      $grpc.ClientMethod<$0.LightCommandRequest, $1.void_>(
          '/APIConnection/light_command',
          ($0.LightCommandRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$switch_command =
      $grpc.ClientMethod<$0.SwitchCommandRequest, $1.void_>(
          '/APIConnection/switch_command',
          ($0.SwitchCommandRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$camera_image =
      $grpc.ClientMethod<$0.CameraImageRequest, $1.void_>(
          '/APIConnection/camera_image',
          ($0.CameraImageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$climate_command =
      $grpc.ClientMethod<$0.ClimateCommandRequest, $1.void_>(
          '/APIConnection/climate_command',
          ($0.ClimateCommandRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));
  static final _$number_command =
      $grpc.ClientMethod<$0.NumberCommandRequest, $1.void_>(
          '/APIConnection/number_command',
          ($0.NumberCommandRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.void_.fromBuffer(value));

  APIConnectionClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.HelloResponse> hello($0.HelloRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hello, request, options: options);
  }

  $grpc.ResponseFuture<$0.ConnectResponse> connect($0.ConnectRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connect, request, options: options);
  }

  $grpc.ResponseFuture<$0.DisconnectResponse> disconnect(
      $0.DisconnectRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnect, request, options: options);
  }

  $grpc.ResponseFuture<$0.PingResponse> ping($0.PingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$ping, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeviceInfoResponse> device_info(
      $0.DeviceInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$device_info, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> list_entities($0.ListEntitiesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$list_entities, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> subscribe_states(
      $0.SubscribeStatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$subscribe_states, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> subscribe_logs($0.SubscribeLogsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$subscribe_logs, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> subscribe_homeassistant_services(
      $0.SubscribeHomeassistantServicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$subscribe_homeassistant_services, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.void_> subscribe_home_assistant_states(
      $0.SubscribeHomeAssistantStatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$subscribe_home_assistant_states, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetTimeResponse> get_time($0.GetTimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get_time, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> execute_service(
      $0.ExecuteServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$execute_service, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> cover_command($0.CoverCommandRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cover_command, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> fan_command($0.FanCommandRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fan_command, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> light_command($0.LightCommandRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$light_command, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> switch_command($0.SwitchCommandRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$switch_command, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> camera_image($0.CameraImageRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$camera_image, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> climate_command(
      $0.ClimateCommandRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$climate_command, request, options: options);
  }

  $grpc.ResponseFuture<$1.void_> number_command($0.NumberCommandRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$number_command, request, options: options);
  }
}

abstract class APIConnectionServiceBase extends $grpc.Service {
  $core.String get $name => 'APIConnection';

  APIConnectionServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloResponse>(
        'hello',
        hello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConnectRequest, $0.ConnectResponse>(
        'connect',
        connect_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ConnectRequest.fromBuffer(value),
        ($0.ConnectResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DisconnectRequest, $0.DisconnectResponse>(
        'disconnect',
        disconnect_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DisconnectRequest.fromBuffer(value),
        ($0.DisconnectResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PingRequest, $0.PingResponse>(
        'ping',
        ping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PingRequest.fromBuffer(value),
        ($0.PingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeviceInfoRequest, $0.DeviceInfoResponse>(
        'device_info',
        device_info_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeviceInfoRequest.fromBuffer(value),
        ($0.DeviceInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListEntitiesRequest, $1.void_>(
        'list_entities',
        list_entities_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListEntitiesRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubscribeStatesRequest, $1.void_>(
        'subscribe_states',
        subscribe_states_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SubscribeStatesRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubscribeLogsRequest, $1.void_>(
        'subscribe_logs',
        subscribe_logs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SubscribeLogsRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SubscribeHomeassistantServicesRequest, $1.void_>(
            'subscribe_homeassistant_services',
            subscribe_homeassistant_services_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SubscribeHomeassistantServicesRequest.fromBuffer(value),
            ($1.void_ value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SubscribeHomeAssistantStatesRequest, $1.void_>(
            'subscribe_home_assistant_states',
            subscribe_home_assistant_states_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SubscribeHomeAssistantStatesRequest.fromBuffer(value),
            ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTimeRequest, $0.GetTimeResponse>(
        'get_time',
        get_time_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTimeRequest.fromBuffer(value),
        ($0.GetTimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExecuteServiceRequest, $1.void_>(
        'execute_service',
        execute_service_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ExecuteServiceRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CoverCommandRequest, $1.void_>(
        'cover_command',
        cover_command_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CoverCommandRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FanCommandRequest, $1.void_>(
        'fan_command',
        fan_command_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FanCommandRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LightCommandRequest, $1.void_>(
        'light_command',
        light_command_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.LightCommandRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SwitchCommandRequest, $1.void_>(
        'switch_command',
        switch_command_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SwitchCommandRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CameraImageRequest, $1.void_>(
        'camera_image',
        camera_image_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CameraImageRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ClimateCommandRequest, $1.void_>(
        'climate_command',
        climate_command_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ClimateCommandRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.NumberCommandRequest, $1.void_>(
        'number_command',
        number_command_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.NumberCommandRequest.fromBuffer(value),
        ($1.void_ value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloResponse> hello_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return hello(call, await request);
  }

  $async.Future<$0.ConnectResponse> connect_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ConnectRequest> request) async {
    return connect(call, await request);
  }

  $async.Future<$0.DisconnectResponse> disconnect_Pre($grpc.ServiceCall call,
      $async.Future<$0.DisconnectRequest> request) async {
    return disconnect(call, await request);
  }

  $async.Future<$0.PingResponse> ping_Pre(
      $grpc.ServiceCall call, $async.Future<$0.PingRequest> request) async {
    return ping(call, await request);
  }

  $async.Future<$0.DeviceInfoResponse> device_info_Pre($grpc.ServiceCall call,
      $async.Future<$0.DeviceInfoRequest> request) async {
    return device_info(call, await request);
  }

  $async.Future<$1.void_> list_entities_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListEntitiesRequest> request) async {
    return list_entities(call, await request);
  }

  $async.Future<$1.void_> subscribe_states_Pre($grpc.ServiceCall call,
      $async.Future<$0.SubscribeStatesRequest> request) async {
    return subscribe_states(call, await request);
  }

  $async.Future<$1.void_> subscribe_logs_Pre($grpc.ServiceCall call,
      $async.Future<$0.SubscribeLogsRequest> request) async {
    return subscribe_logs(call, await request);
  }

  $async.Future<$1.void_> subscribe_homeassistant_services_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SubscribeHomeassistantServicesRequest> request) async {
    return subscribe_homeassistant_services(call, await request);
  }

  $async.Future<$1.void_> subscribe_home_assistant_states_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SubscribeHomeAssistantStatesRequest> request) async {
    return subscribe_home_assistant_states(call, await request);
  }

  $async.Future<$0.GetTimeResponse> get_time_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetTimeRequest> request) async {
    return get_time(call, await request);
  }

  $async.Future<$1.void_> execute_service_Pre($grpc.ServiceCall call,
      $async.Future<$0.ExecuteServiceRequest> request) async {
    return execute_service(call, await request);
  }

  $async.Future<$1.void_> cover_command_Pre($grpc.ServiceCall call,
      $async.Future<$0.CoverCommandRequest> request) async {
    return cover_command(call, await request);
  }

  $async.Future<$1.void_> fan_command_Pre($grpc.ServiceCall call,
      $async.Future<$0.FanCommandRequest> request) async {
    return fan_command(call, await request);
  }

  $async.Future<$1.void_> light_command_Pre($grpc.ServiceCall call,
      $async.Future<$0.LightCommandRequest> request) async {
    return light_command(call, await request);
  }

  $async.Future<$1.void_> switch_command_Pre($grpc.ServiceCall call,
      $async.Future<$0.SwitchCommandRequest> request) async {
    return switch_command(call, await request);
  }

  $async.Future<$1.void_> camera_image_Pre($grpc.ServiceCall call,
      $async.Future<$0.CameraImageRequest> request) async {
    return camera_image(call, await request);
  }

  $async.Future<$1.void_> climate_command_Pre($grpc.ServiceCall call,
      $async.Future<$0.ClimateCommandRequest> request) async {
    return climate_command(call, await request);
  }

  $async.Future<$1.void_> number_command_Pre($grpc.ServiceCall call,
      $async.Future<$0.NumberCommandRequest> request) async {
    return number_command(call, await request);
  }

  $async.Future<$0.HelloResponse> hello(
      $grpc.ServiceCall call, $0.HelloRequest request);
  $async.Future<$0.ConnectResponse> connect(
      $grpc.ServiceCall call, $0.ConnectRequest request);
  $async.Future<$0.DisconnectResponse> disconnect(
      $grpc.ServiceCall call, $0.DisconnectRequest request);
  $async.Future<$0.PingResponse> ping(
      $grpc.ServiceCall call, $0.PingRequest request);
  $async.Future<$0.DeviceInfoResponse> device_info(
      $grpc.ServiceCall call, $0.DeviceInfoRequest request);
  $async.Future<$1.void_> list_entities(
      $grpc.ServiceCall call, $0.ListEntitiesRequest request);
  $async.Future<$1.void_> subscribe_states(
      $grpc.ServiceCall call, $0.SubscribeStatesRequest request);
  $async.Future<$1.void_> subscribe_logs(
      $grpc.ServiceCall call, $0.SubscribeLogsRequest request);
  $async.Future<$1.void_> subscribe_homeassistant_services(
      $grpc.ServiceCall call, $0.SubscribeHomeassistantServicesRequest request);
  $async.Future<$1.void_> subscribe_home_assistant_states(
      $grpc.ServiceCall call, $0.SubscribeHomeAssistantStatesRequest request);
  $async.Future<$0.GetTimeResponse> get_time(
      $grpc.ServiceCall call, $0.GetTimeRequest request);
  $async.Future<$1.void_> execute_service(
      $grpc.ServiceCall call, $0.ExecuteServiceRequest request);
  $async.Future<$1.void_> cover_command(
      $grpc.ServiceCall call, $0.CoverCommandRequest request);
  $async.Future<$1.void_> fan_command(
      $grpc.ServiceCall call, $0.FanCommandRequest request);
  $async.Future<$1.void_> light_command(
      $grpc.ServiceCall call, $0.LightCommandRequest request);
  $async.Future<$1.void_> switch_command(
      $grpc.ServiceCall call, $0.SwitchCommandRequest request);
  $async.Future<$1.void_> camera_image(
      $grpc.ServiceCall call, $0.CameraImageRequest request);
  $async.Future<$1.void_> climate_command(
      $grpc.ServiceCall call, $0.ClimateCommandRequest request);
  $async.Future<$1.void_> number_command(
      $grpc.ServiceCall call, $0.NumberCommandRequest request);
}
