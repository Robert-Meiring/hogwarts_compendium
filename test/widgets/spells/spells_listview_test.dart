import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/models/spells/spell.dart';
import 'package:hogwarts_compendium/tabs/spells/widgets/spells_listview.dart';

void main() {
  // Set up the dependencies before running tests
  RegisterFactory().setup();

  testWidgets('SpellsListview displays spells', (WidgetTester tester) async {
    // Define test data
    final spells = [
      Spell(
        id: '1',
        name: 'Disarmament Charm',
        incantation: 'Expelliarmus',
        effect: 'Disarms your opponent',
        canBeVerbal: true,
        type: 'Charm',
        light: 'Red',
        creator: 'Unknown',
      ),
      Spell(
        id: '2',
        name: 'Light Charm',
        incantation: 'Lumos',
        effect: 'Creates light',
        canBeVerbal: true,
        type: 'Charm',
        light: 'White',
        creator: 'Unknown',
      ),
    ];

    // Build the widget tree and pump it into the tester
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpellsListview(spells: spells),
        ),
      ),
    );

    // Verify if the spells' names are displayed
    expect(find.text('DISARMAMENT CHARM'), findsOneWidget);
    expect(find.text('LUMOS'), findsOneWidget);
  });
}
