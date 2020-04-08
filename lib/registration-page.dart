import 'package:flutter/material.dart';
import 'package:my_fit/models/user.dart';
import 'package:my_fit/common/form/form-body.dart';
import 'package:my_fit/common/form/form-footer.dart';
import 'package:my_fit/common/form/form-header.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as Validators;

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _RegistrationForm(_navigateToHomePage),
      ),
    );
  }

  /// Navigate to home page.
  void _navigateToHomePage() {
    Navigator.of(context).pushReplacementNamed('/');
  }
}

class _RegistrationForm extends StatefulWidget {
  /// Callback to call after successful submission of a form.
  final void Function() _onSuccessCallback;

  _RegistrationForm(this._onSuccessCallback);

  @override
  State<StatefulWidget> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<_RegistrationForm> {
  /// Registration form title.
  static const _formTitle = 'Sign up for My Fit';

  /// Form key to control form.
  final _formKey = GlobalKey<FormState>();

  /// Textfield controllers.
  final _loginFieldController = TextEditingController();
  final _passwordRepeatFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  /// Async validation error.
  AuthResultError _authResultError;

  @override
  void dispose() {
    _loginFieldController.dispose();
    _passwordFieldController.dispose();
    _passwordRepeatFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FormHeader(_formTitle),
          FormBody(
            children: <Widget>[
              TextFormField(
                controller: _loginFieldController,
                validator: _validateLoginField,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextFormField(
                controller: _passwordFieldController,
                validator: _validatePasswordField,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              TextFormField(
                controller: _passwordRepeatFieldController,
                validator: _validatePasswordRepeatFieldController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Repeat password',
                ),
              )
            ],
          ),
          FormFooter(
            children: <Widget>[
              RaisedButton(
                onPressed: _submitForm,
                child: Text('Create'),
              ),
              OutlineButton(
                onPressed: () => _navigateToLogin(context),
                child: Text('I already have an acount'),
              )
            ],
          ),
        ],
      ),
    );
  }

  /// Login field validator.
  String _validateLoginField(String value) {
    if (!Validators.isEmail(value)) {
      return 'Make sure login is an email';
    } else if (_authResultError != null) {
      return _authResultError.login;
    }
    return null;
  }

  /// Password field validator.
  String _validatePasswordField(String value) {
    const passwordMinLen = 6;
    if (!Validators.isLength(value, passwordMinLen)) {
      return 'Password length must be more than $passwordMinLen';
    } else if (_authResultError != null) {
      return _authResultError.password;
    }
    return null;
  }

  /// Password repeat field validator.
  String _validatePasswordRepeatFieldController(String value) {
    if (_passwordFieldController.value.text != value) {
      return 'Password fields must match';
    }
    return null;
  }

  /// Submit form action.
  Future<void> _submitForm() async {
    if (_formKey.currentState.validate()) {
      final result = await Provider.of<UserModel>(context, listen: false).login(
        _loginFieldController.value.text,
        _passwordFieldController.value.text,
      );
      if (result.error != null) {
        _authResultError = result.error;
        _formKey.currentState.validate();
        return;
      }

      widget._onSuccessCallback();
    }
  }

  /// Navigate to login page.
  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
