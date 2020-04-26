import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  /// Header text.
  final String text;

  FormHeader(this.text);

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 70,
      color: Theme.of(context).primaryColor,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        text.toUpperCase(),
        style: headerStyle,
      ),
    );
  }
}
