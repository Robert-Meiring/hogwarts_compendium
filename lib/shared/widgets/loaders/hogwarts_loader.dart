import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HogwartsLoader extends StatelessWidget {
  const HogwartsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenW, // Set the width of the loader to the screen width
      height: screenW, // Set the height of the loader to the screen width
      child: const RiveAnimation.asset(
        'assets/loaders/potion.riv', // Path to the Rive animation asset
        antialiasing: true, // Enable antialiasing for smoother animation
        fit: BoxFit.contain, // Fit the animation within the box
      ),
    );
  }
}
