import 'package:flutter/material.dart';

class HogwartsScaleAnimation extends StatelessWidget {
  const HogwartsScaleAnimation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.linearToEaseOut, // Curve for the switch in animation
      switchOutCurve: Curves.linearToEaseOut, // Curve for the switch out animation
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(
        opacity: animation, // Fade transition for opacity
        child: ScaleTransition(
          scale: animation, // Scale transition for size
          child: child,
        ),
      ),
      duration: const Duration(milliseconds: 350), // Duration of the animation
      child: child,
    );
  }
}
