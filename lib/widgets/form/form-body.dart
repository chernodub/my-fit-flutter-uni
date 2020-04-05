import 'package:flutter/material.dart';

class FormBody extends StatelessWidget {
  final List<Widget> children;

  FormBody({this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children.map(_transformChild).toList(),
    );
  }

  /// Transform formbody child.
  Widget _transformChild(Widget child) {
    final formBodyChildPadding =
        const EdgeInsets.symmetric(vertical: 4, horizontal: 8);

    return Container(
      padding: formBodyChildPadding,
      child: child,
    );
  }
}
