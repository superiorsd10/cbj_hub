abstract class IInternetDeviceRepository {
  IInternetDeviceRepository(this.id, this.name, this.topic);

  /// Id of the device
  String id;

  /// Default name of the device
  String name;

  /// What mqtt topic will write to and get updated if value changed
  String topic;
}
