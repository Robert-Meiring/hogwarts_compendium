import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hogwarts_compendium/detail_view/detail_view_screen.dart';
import 'package:hogwarts_compendium/shared/models/spells/spell.dart';

void main() {
  // Test for DetailViewScreen to check if it displays correct data
  testWidgets('DetailViewScreen displays correct data', (WidgetTester tester) async {
    final spell = Spell(
      id: '1',
      name: 'Expelliarmus',
      incantation: 'Expelliarmus',
      effect: 'Disarms your opponent',
      canBeVerbal: true,
      type: 'Charm',
      light: 'Red',
      creator: 'Unknown',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: DetailViewScreen(
          imagePath: 'assets/icons/wand.svg',
          data: spell.toJson(),
        ),
      ),
    );

    // Check if the spell's name, incantation, and effect are displayed correctly
    expect(find.text('NAME: EXPELLIARMUS'), findsOneWidget);
    expect(find.text('INCANTATION: EXPELLIARMUS'), findsOneWidget);
    expect(find.text('EFFECT: DISARMS YOUR OPPONENT'), findsOneWidget);
  });
}
