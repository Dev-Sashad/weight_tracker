import 'package:flutter/material.dart';
import 'package:weight_traker/core/services/auth_service.dart';
import 'package:weight_traker/utils/constants/helpers.dart';
import 'package:weight_traker/utils/constants/locator.dart';
import 'package:weight_traker/utils/constants/validator.dart';
import 'package:weight_traker/utils/dialogeManager/dialogService.dart';
import 'package:weight_traker/utils/router/navigationService.dart';
import 'package:weight_traker/utils/baseModel/baseModel.dart';

class ResetPasswordViewModel extends BaseModel {
  bool _visiblePassword = true;
  bool get visiblePassword => _visiblePassword;
  final AuthService _authentication = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ProgressService _progressService = locator<ProgressService>();

  setvisiblePassword() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

  resetpassword(String oldPassword, String newPassword,
      GlobalKey<FormState> formKey) async {
    if (validate(formKey)) {
      try {
        var isConnected = await checkInternet();
        if (isConnected == false) {
          _progressService.showDialog(
              title: 'No Connection!',
              description: 'Please check your internet connection!');
        } else {
          _authentication.resetpassword(oldPassword, newPassword);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void pop() {
    _navigationService.pop();
  }
}
