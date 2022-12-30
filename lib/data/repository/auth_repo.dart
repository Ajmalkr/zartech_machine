import 'package:aju_machine_test/data/api/api_client.dart';
import 'package:aju_machine_test/util/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.apiClient, @required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.USER);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.USER);
    return true;
  }

  String getUser() {
    return sharedPreferences.getString(AppConstants.USER) ?? "";
  }

  void setUser(String name) {
    sharedPreferences.setString(AppConstants.USER, name);
  }
}
