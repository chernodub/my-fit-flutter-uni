import 'dart:async';

import 'package:flutter/material.dart';

class SplashContainer extends StatefulWidget {
  final BuildContext context;
  final Widget child;
  SplashContainer({@required this.context, this.child});

  @override
  State<StatefulWidget> createState() => _AnimatedSplashContainerState(context);
}

class _AnimatedSplashContainerState extends State<SplashContainer> {
  final animationDuration = Duration(milliseconds: 1000);
  final curve = Curves.easeInOutCubic;
  Gradient currentGradient;

  Timer timer;

  _AnimatedSplashContainerState(BuildContext context) {
    final theme = Theme.of(context);

    /// TODO refactor this logic
    final gradientOptions = [
      LinearGradient(colors: [
        theme.splashColor,
        theme.splashColor,
        theme.splashColor,
        theme.splashColor,
        theme.splashColor,
      ]),
      LinearGradient(colors: [
        theme.accentColor,
        theme.splashColor,
        theme.splashColor,
        theme.splashColor,
        theme.accentColor,
      ]),
    ];

    int currentIdx = 0;
    currentGradient = gradientOptions[currentIdx];

    timer = Timer.periodic(
      animationDuration,
      (_) => setState(() {
        currentGradient =
            gradientOptions[++currentIdx % gradientOptions.length];
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
