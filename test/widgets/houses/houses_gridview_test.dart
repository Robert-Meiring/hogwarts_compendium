import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/models/houses/house.dart';
import 'package:hogwarts_compendium/tabs/houses/widgets/houses_gridview.dart';
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

  testWidgets('HousesGridView displays houses', (WidgetTester tester) async {
    // Define test data
    final houses = [
      House(
        id: '1',
        name: 'Gryffindor',
        houseColours: 'Scarlet and Gold',
        founder: 'Godric Gryffindor',
        animal: 'Lion',
        element: 'Fire',
        ghost: 'Nearly Headless Nick',
        commonRoom: 'Gryffindor Tower',
        heads: [],
        traits: [],
      ),
      House(
        id: '2',
        name: 'Hufflepuff',
        houseColours: 'Yellow and Black',
        founder: 'Helga Hufflepuff',
        animal: 'Badger',
        element: 'Earth',
        ghost: 'The Fat Friar',
        commonRoom: 'Hufflepuff Basement',
        heads: [],
        traits: [],
      ),
    ];

    // Build the widget tree and pump it into the tester
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HousesGridview(houses: houses),
        ),
      ),
    );

    // Verify if the houses' names are displayed
    expect(find.text('GRYFFINDOR'), findsOneWidget);
    expect(find.text('HUFFLEPUFF'), findsOneWidget);
  });
}
