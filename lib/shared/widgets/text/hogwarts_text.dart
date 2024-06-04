import 'package:flutter/material.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';

class HogwartsText extends StatelessWidget {
  const HogwartsText({
    super.key,
    this.fontScale,
    required this.text,
    this.altColor,
    this.textAlign,
  });

  final double? fontScale; // Optional scale factor for the font size
  final String text; // The text to display
  final bool? altColor; // Optional flag to use alternate color
  final TextAlign? textAlign; // Optional text alignment

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: altColor != null && altColor!
            ? HogwartsStyle.accent // Use accent color if altColor is true
            : HogwartsStyle.foreground, // Use foreground color otherwise
      ),
      textScaler: TextScaler.linear(fontScale ?? 1.0), // Apply font scaling
      textAlign: textAlign, // Apply text alignment
    );
  }
}
