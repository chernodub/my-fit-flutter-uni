import 'dart:async';

import 'package:flutter/material.dart';

class SplashContainer extends StatefulWidget {
  final Widget child;
  SplashContainer({this.child});

  @override
  State<StatefulWidget> createState() => _AnimatedSplashContainerState();
}

class _AnimatedSplashContainerState extends State<SplashContainer> {
  final animationDuration = Duration(milliseconds: 1000);
  final curve = Curves.easeInOutCubic;
  List<Gradient> gradientOptions;
  Gradient currentGradient;

  Timer timer;

  _AnimatedSplashContainerState() {
    int currentIdx = 0;

    timer = Timer.periodic(
      animationDuration,
      (_) => setState(() {
        if (gradientOptions == null) {
          return;
        }
        currentGradient =
            gradientOptions[currentIdx++ % gradientOptions.length];
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    gradientOptions = [
      LinearGradient(colors: [
        theme.splashColor,
        theme.splashColor,
        theme.splashColor,
        theme.splashColor,
        theme.splashColor,
      ]),
      LinearGradient(colors: [
        theme.primaryColorLight,
        theme.splashColor,
        theme.splashColor,
        theme.splashColor,
        theme.primaryColorLight,
      ]),
    ];
    return AnimatedContainer(
      child: widget.child,
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor,
        gradient: currentGradient,
      ),
      duration: animationDuration,
      curve: curve,
    );
  }
}
