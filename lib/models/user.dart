import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_fit/models/app-config.dart';

class FormResult<SuccessResult, ErrorResult> {
  /// Error.
  ErrorResult error;

  /// Success value.
  SuccessResult success;

  FormResult({this.error, this.success});
}

String extractValidationError(String formPath, dynamic validationObj) {
  final List<String> path = formPath.split('.');
  return path.length == 1
      ? validationObj[path[0]]
      : extractValidationError(path.sublist(1).join('.'), validationObj);
}

class AuthValidationError {
  /// Login field error.
  String login;

  /// Password field error.
  String password;
  AuthValidationError({this.password, this.login});

  factory AuthValidationError.fromDto(Map<String, dynamic> json) {
    return AuthValidationError(
      login: extractValidationError('email', json),
      password: extractValidationError('password', json),
    );
  }
}

/// User class.
class User {
  final String email;
  final UserMetadata meta;

  User(this.email, this.meta);

  factory User.fromDto(Map<String, dynamic> json) {
    return User(json['email'], UserMetadata(token: json['token']));
  }
}

/// Contains user metadata (e.g. token and other).
class UserMetadata {
  final String token;
  UserMetadata({@required this.token});
}

class UserModel extends ChangeNotifier {
  /// Current user.
  User _currentUser;

  /// Current user.
  User get user => _currentUser;

  /// Perform login.
  Future<FormResult<void, AuthValidationError>> login(
      String login, String password) async {
    final body = {
      "email": login,
      "password": password,
    };
    final response = await http.post(
      '${AppConfig.apiUrl}users/login',
      body: body,
    );
    if (response.statusCode == 200) {
      _currentUser = User.fromDto(json.decode(response.body));
      notifyListeners();
      return FormResult();
    }

    return FormResult(
      error: AuthValidationError.fromDto(json.decode(response.body)),
    );
  }

  /// Perform registration.
  Future<FormResult<void, AuthValidationError>> register(
      String login, String password) async {
    final body = {
      "email": login,
      "password": password,
    };
    final response = await http.post(
      '${AppConfig.apiUrl}users/',
      body: body,
    );

    if (response.statusCode == 201) {
      _currentUser = User.fromDto(json.decode(response.body));
      notifyListeners();
      return FormResult();
    }

    return FormResult(
        error: AuthValidationError.fromDto(json.decode(response.body)));
  }
}
