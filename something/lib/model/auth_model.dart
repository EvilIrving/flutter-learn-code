 
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:something/api/personal_api.dart';
import 'package:something/service_locator.dart';
import 'package:something/utils/local_storage_service.dart';

class RegisterForm {
  String? username;
  String? password;
  String? repassword;
}

class LoginForm {
  String? username = 'woshidaren';
  String? password = '123456';
}

class LoginModel extends ChangeNotifier {
  LoginForm loginForm = LoginForm();
  final LocalStorageService storageService = locator<LocalStorageService>();

  Future<bool> loginUser() async {
    if (!isValid()) {
      return false;
    }

    bool result = await PersonalApi.login(
        loginForm.username ?? '', loginForm.password ?? '');
    if (result) {
      storageService.userName = loginForm.username ?? '';
      showToast('Login successful');
    } else {
      showToast('Login failed');
    }
    return true;
  }

  bool isValid() {
    final String username = loginForm.username ?? '';
    final String password = loginForm.password ?? '';

    if (username.isEmpty || password.isEmpty) {
      showToast('Please fill all fields');
      return false;
    }

    if (password.length < 6) {
      showToast('Password should be at least 6 characters long');
      return false;
    }

    return true;
  }
}

class AuthModel extends ChangeNotifier {
  RegisterForm registerForm = RegisterForm();

  Future<bool> registerUser() async {
    if (!isValid()) {
      return false;
    }

    bool result = await PersonalApi.register(registerForm.username ?? '',
        registerForm.password ?? '', registerForm.repassword ?? '');
    if (result) {
      showToast('Registration successful');
    } else {
      showToast('Registration failed');
    }
    return true;
  }

  bool isValid() {
    final String username = registerForm.username ?? '';
    final String password = registerForm.password ?? '';
    final String repassword = registerForm.repassword ?? '';
    if (password != repassword) {
      showToast('Passwords do not match');
      return false;
    }

    if (username.isEmpty || password.isEmpty || repassword.isEmpty) {
      showToast('Please fill all fields');
      return false;
    }

    if (password.length < 6) {
      showToast('Password should be at least 6 characters long');
      return false;
    }

    return true;
  }
}
