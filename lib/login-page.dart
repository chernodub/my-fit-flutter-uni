import 'package:flutter/material.dart';
import 'package:my_fit/providers/auth.provider.dart';
import 'package:validators/validators.dart' as Validators;

import 'home-page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _LoginForm(_navigateToHomePage),
      ),
    );
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}

class _LoginForm extends StatefulWidget {
  final Function() onSuccessCallback;

  _LoginForm(this.onSuccessCallback);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  /// Login form title.
  static const _formTitle = 'Sign in';

  /// Formkey to control the form.
  final _formKey = GlobalKey<FormState>();

  /// Login field controller.
  final _loginFieldController = TextEditingController();

  /// Password field controller.
  final _passwordFieldController = TextEditingController();

  /// Async validation result.
  LoginErrorValidationResult _errorValidationResult;

  /// Auth provider.
  final authProvider = new AuthProvider();

  @override
  Widget build(BuildContext context) {
    final textFieldPadding =
        const EdgeInsets.symmetric(vertical: 4, horizontal: 8);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildFormHeader(),
          Padding(
            padding: textFieldPadding,
            child: TextFormField(
              controller: _loginFieldController,
              validator: _validateLoginField,
            ),
          ),
          Padding(
            padding: textFieldPadding,
            child: TextFormField(
              controller: _passwordFieldController,
              validator: _validatePasswordField,
              obscureText: true,
            ),
          ),
          RaisedButton(
            onPressed: _submitForm,
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _loginFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  /// Submit form.
  Future<void> _submitForm() async {
    if (_formKey.currentState.validate()) {
      final loginActionResult = await authProvider.login(
        _loginFieldController.value,
        _passwordFieldController.value,
      );

      if (loginActionResult.error != null) {
        _errorValidationResult = loginActionResult.error;
        _formKey.currentState.validate();
        _errorValidationResult = null; // To show async validation only once.
        return;
      }

      widget.onSuccessCallback();
    }
  }

  /// Build form header.
  Widget _buildFormHeader() {
    final headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    return Text(
      _formTitle,
      style: headerStyle,
    );
  }

  /// Login field validation function.
  String _validateLoginField(String value) {
    if (!Validators.isEmail(value))
      return 'Login must be an email';
    else if (_errorValidationResult != null)
      return _errorValidationResult.login;
    return null;
  }

  /// Password field validator.
  String _validatePasswordField(String value) {
    const passwordMinLen = 6;
    if (!Validators.isLength(value, passwordMinLen))
      return 'Min length is $passwordMinLen';
    else if (_errorValidationResult != null)
      return _errorValidationResult.password;
    return null;
  }
}
