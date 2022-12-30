import 'package:aju_machine_test/data/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({@required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  bool _firstTimeConnectionCheck = true;

  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void saveUser(String name) {
    authRepo.setUser(name);
  }

  String getUser() {
    return authRepo.getUser() ?? "";
  }
}
