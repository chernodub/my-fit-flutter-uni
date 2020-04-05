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
  /// Current user.
  User _currentUser;

  /// Current user.
  User get user => _currentUser;

  /// Perform login.
  Future<AuthResult<void, AuthResultError>> login(
      String login, String password) async {
    /// TODO remove
    await Future.delayed(
      Duration(milliseconds: 200),
    );

    return AuthResult();
  }

  /// Perform registration.
  Future<AuthResult<void, AuthResultError>> register(
      String login, String password) async {
    /// TODO remove
    await Future.delayed(
      Duration(milliseconds: 200),
    );

    return AuthResult();
  }
}
