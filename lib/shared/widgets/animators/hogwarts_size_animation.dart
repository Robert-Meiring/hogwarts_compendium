import 'package:flutter/material.dart';

class HogwartsSizeAnimation extends StatelessWidget {
  const HogwartsSizeAnimation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.linearToEaseOut, // Curve for the switch in animation
      switchOutCurve: Curves.linearToEaseOut, // Curve for the switch out animation
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(
        opacity: animation, // Fade transition for opacity
        child: SizeTransition(
          sizeFactor: animation, // Size transition for vertical size
          axis: Axis.vertical,
          child: child,
        ),
      ),
      duration: const Duration(milliseconds: 350), // Duration of the animation
      child: child,
    );
  }
}
