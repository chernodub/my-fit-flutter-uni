class AuthResult<SuccessResult, ErrorResult> {
  ErrorResult error;
  SuccessResult success;
  AuthResult({this.error, this.success});
}

class LoginErrorValidationResult {
  String login;
  String password;
  LoginErrorValidationResult({this.password, this.login});
}

class AuthProvider {
  Future<AuthResult<void, LoginErrorValidationResult>> login(
      login, password) async {
    await Future.delayed(
      Duration(milliseconds: 200),
    );

    return AuthResult();
  }
}
