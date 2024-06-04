import 'package:flutter/material.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/text/hogwarts_text.dart';

class TabTitle extends StatelessWidget {
  const TabTitle({super.key, required this.title, required this.currentlySelected});
  final String title;
  final bool currentlySelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: HogwartsStyle.backgroundAlt,
        child: Center(
          child: HogwartsText(
            text: title.toUpperCase(),
            fontScale: 1.8,
            altColor: currentlySelected, // Highlight the selected tab
          ),
        ),
      ),
    );
  }
}
