import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  final List<Widget> children;

  FormFooter({this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children,
    );
  }
}
