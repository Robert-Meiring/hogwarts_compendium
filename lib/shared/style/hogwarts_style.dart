import 'package:flutter/material.dart';

class HogwartsStyle {
  // Border radii
  static const borderRadiusSingle = Radius.circular(16);
  static const borderRadius = BorderRadius.all(Radius.circular(16));
  static const borderRadiusButton = BorderRadius.all(Radius.circular(32));

  // Elevation for material widgets
  static const elevation = 3.0;

  // Colors
  static const background = Color.fromRGBO(0, 0, 0, 1); // Black
  static const backgroundAlt = Color.fromRGBO(20, 20, 20, 1); // Dark grey
  static const foreground = Color.fromRGBO(255, 255, 255, 1); // White
  static const accent = Color.fromRGBO(235, 179, 42, 1); // Gold
  static const accentAlt = Color.fromRGBO(205, 156, 33, 1); // Darker gold
  static const error = Color.fromRGBO(164, 0, 1, 1); // Red
  static const errorAlt = Color.fromRGBO(105, 0, 1, 1); // Darker red

  // Gradients
  static const accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [accent, accentAlt],
  );
  static const errorGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [error, errorAlt],
  );
}
