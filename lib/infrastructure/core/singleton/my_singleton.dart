import 'package:cbj_hub/infrastructure/core/singleton/my_singleton_helper.dart';

class MySingleton {
  factory MySingleton() {
    return _singleton;
  }

  MySingleton._internal() {
    getUuid();
    getCurrentUserName();
    getLocalDbPath();
  }

  static final MySingleton _singleton = MySingleton._internal();
  static Future<String>? _deviceUid;
  static Future<String>? _currentUserName;
  static Future<String>? _localDbPath;

  static Future<String> getUuid() => _deviceUid ??= MySingletonHelper.getUuid();

  static Future<String?> getCurrentUserName() =>
      _currentUserName ??= MySingletonHelper.getCurrentUserName();

  static Future<String?> getLocalDbPath() =>
      _localDbPath ??= MySingletonHelper.getLocalDbPath();
}

class FirebaseAccountInformationFlutter {
  FirebaseAccountInformationFlutter(this.fireBaseProjectId, this.fireBaseApiKey,
      this.userEmail, this.userPassword);

  String fireBaseProjectId;
  String fireBaseApiKey;
  String userEmail;
  String userPassword;

  bool areAllValuesNotNull() {
    return fireBaseProjectId != null &&
        fireBaseApiKey != null &&
        userEmail != null &&
        userPassword != null;
  }
}
