import 'package:flutter/cupertino.dart';

class FormHeader extends StatelessWidget {
  /// Header text.
  final String text;

  FormHeader(this.text);

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    return Text(
      text,
      style: headerStyle,
    );
  }
}
