import 'package:flutter/material.dart';

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
        child: _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  static const _formTitle = 'Sign in';

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
              validator: (value) => require(value, 'login'),
            ),
          ),
          Padding(
            padding: textFieldPadding,
            child: TextFormField(
              obscureText: true,
              validator: (value) => require(value, 'password'),
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

  /// Submit form.
  void _submitForm() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  /// Build form header.
  Widget _buildFormHeader() {
    final headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    return Text(
      _formTitle,
      style: headerStyle,
    );
  }
}

/// Validator for a required field.
String require(String value, String fieldName) {
  return value.isEmpty ? 'Please enter a $fieldName' : null;
}
