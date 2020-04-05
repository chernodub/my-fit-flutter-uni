import 'package:flutter/material.dart';
import 'package:my_fit/home-page.dart';
import 'package:my_fit/models/user.model.dart';
import 'package:my_fit/registration-page.dart';
import 'package:my_fit/widgets/form/form-body.dart';
import 'package:my_fit/widgets/form/form-footer.dart';
import 'package:my_fit/widgets/form/form-header.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as Validators;

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
  final Function() _onSuccessCallback;

  _LoginForm(this._onSuccessCallback);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  /// Login form title.
  static const _formTitle = 'Sign in';

  /// Formkey to control the form.
  final _formKey = GlobalKey<FormState>();

  /// Textfield controllers.
  final _loginFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  /// Async validation result.
  AuthResultError _errorValidationResult;

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
              ),
              TextFormField(
                controller: _passwordFieldController,
                validator: _validatePasswordField,
                obscureText: true,
              )
            ],
          ),
          FormFooter(
            children: <Widget>[
              RaisedButton(
                onPressed: () => _submitForm(context),
                child: Text('OK'),
              ),
              OutlineButton(
                onPressed: () => _navigateToRegistration(context),
                child: Text('I don\'t have an acount'),
              )
            ],
          )
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
  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final loginActionResult =
          await Provider.of<UserModel>(context, listen: false).login(
        _loginFieldController.value.text,
        _passwordFieldController.value.text,
      );

      if (loginActionResult.error != null) {
        _errorValidationResult = loginActionResult.error;
        _formKey.currentState.validate();
        _errorValidationResult = null; // To show async validation only once.
        return;
      }

      widget._onSuccessCallback();
    }
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

  void _navigateToRegistration(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RegistrationPage(),
      ),
    );
  }
}
