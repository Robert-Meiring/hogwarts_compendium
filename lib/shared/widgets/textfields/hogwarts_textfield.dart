import 'package:flutter/material.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';

class HogwartsTextfield extends StatelessWidget {
  const HogwartsTextfield({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final TextEditingController controller; // Controller for the text field
  final String hintText; // Hint text to display in the text field

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: HogwartsStyle.backgroundAlt, // Background color of the text field
        borderRadius:
            HogwartsStyle.borderRadius, // Border radius for rounded corners
      ),
      child: TextField(
        controller: controller, // Assigning the controller to the text field
        cursorColor: HogwartsStyle.accent, // Cursor color
        style: const TextStyle(
          color: HogwartsStyle.foreground, // Text color
          fontSize: 24, // Font size
        ),
        decoration: InputDecoration(
          hintText: hintText, // Display hint text
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ), // Padding inside the text field
          hintStyle: const TextStyle(
            color: HogwartsStyle.foreground, // Hint text color
            fontSize: 24, // Hint text font size
          ),
          border: InputBorder.none, // No border for the text field
        ),
      ),
    );
  }
}
