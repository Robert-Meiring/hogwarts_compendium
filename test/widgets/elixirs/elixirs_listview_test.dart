import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/models/elixirs/elixir.dart';
import 'package:hogwarts_compendium/tabs/elixirs/widgets/elixirs_listview.dart';
import 'package:get_it/get_it.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_bloc.dart';

// Initialize the GetIt instance
final sl = GetIt.instance;

// Function to set up test dependencies
void setupTestDependencies() {
  sl.registerLazySingleton<HomeScreenBloc>(() => HomeScreenBloc());
}

void main() {
  // Set up dependencies before running tests
  RegisterFactory().setup();

  testWidgets('ElixirsListView displays elixirs', (WidgetTester tester) async {
    // Define test data
    final elixirs = [
      Elixir(
        id: '1',
        name: 'Felix Felicis',
        effect: 'Luck',
        sideEffects: 'Overconfidence',
        characteristics: 'Golden',
        time: 'Brewed for 6 months',
        difficulty: 'Advanced',
        ingredients: [],
        inventors: [],
        manufacturer: 'Slughorn',
      ),
      Elixir(
        id: '2',
        name: 'Polyjuice Potion',
        effect: 'Transforms user into someone else',
        sideEffects: 'None if prepared correctly',
        characteristics: 'Varies depending on ingredients',
        time: 'Brewed for 1 month',
        difficulty: 'Advanced',
        ingredients: [],
        inventors: [],
        manufacturer: 'Unknown',
      ),
    ];

    // Build the widget tree and pump it into the tester
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ElixirsListview(elixirs: elixirs),
        ),
      ),
    );

    // Verify if the elixirs' names are displayed
    expect(find.text('FELIX FELICIS'), findsOneWidget);
    expect(find.text('POLYJUICE POTION'), findsOneWidget);
  });
}
