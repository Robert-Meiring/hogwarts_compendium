import 'package:flutter/material.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/text/hogwarts_text.dart';

class HogwartsSnackbars {
  // Method to show an error snackbar with a custom message
  static void showErrorSnackbar(BuildContext context, String errorMessage) {
    final snackBar = SnackBar(
      content: HogwartsText(
        text: errorMessage,
        fontScale: 1.3,
      ),
      backgroundColor: HogwartsStyle.error, // Error background color
      behavior: SnackBarBehavior.floating, // Floating behavior for the snackbar
      shape: const RoundedRectangleBorder(
        borderRadius: HogwartsStyle.borderRadius, // Custom border radius
      ),
    );

    // Show the snackbar using ScaffoldMessenger
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
