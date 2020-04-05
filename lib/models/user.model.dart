import 'package:flutter/material.dart';

class AuthResult<SuccessResult, ErrorResult> {
  ErrorResult error;
  SuccessResult success;
  AuthResult({this.error, this.success});
}

class AuthResultError {
  String login;
  String password;
  AuthResultError({this.password, this.login});
}

/// User class.
class User {
  final String email;
  final UserMetadata meta;

  User(this.email, this.meta);
}

/// Contains user metadata (e.g. token and other).
class UserMetadata {}

class UserModel extends ChangeNotifier {
  User _currentUser;

  User get user => _currentUser;

  Future<AuthResult<void, AuthResultError>> login(
      String login, String password) async {
    await Future.delayed(
      Duration(milliseconds: 200),
    );

    return AuthResult();
  }

  Future<AuthResult<void, AuthResultError>> register(
      String login, String password) async {
    await Future.delayed(
      Duration(milliseconds: 200),
    );

    return AuthResult();
  }
}
