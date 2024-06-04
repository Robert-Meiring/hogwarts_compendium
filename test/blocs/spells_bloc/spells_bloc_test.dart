import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_bloc.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_events.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_states.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'spells_bloc_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  // Set up a new instance of MockClient before each test
  setUp(() {
    mockClient = MockClient();
  });

  group('SpellsBloc', () {
    // Test to verify the initial state of SpellsBloc
    test('initial state is InitialSpellsState', () {
      final spellsBloc = SpellsBloc(client: mockClient);
      expect(spellsBloc.state, InitialSpellsState());
    });

    // Test for successful fetch of spells
    blocTest<SpellsBloc, SpellsStates>(
      'emits [GetSpellsBusy, GetSpellsSuccess] when GetSpells is added and fetch is successful',
      build: () {
        // Mock a successful API response
        when(mockClient
                .get(Uri.parse("https://wizard-world-api.herokuapp.com/Spells")))
            .thenAnswer((_) async => http.Response(
                json.encode([
                  {
                    "id": "1",
                    "name": "Expelliarmus",
                    "incantation": "Expelliarmus",
                    "effect": "Disarms your opponent",
                    "canBeVerbal": true,
                    "type": "Charm",
                    "light": "Red",
                    "creator": "Unknown"
                  }
                ]),
                200));
        return SpellsBloc(client: mockClient);
      },
      act: (bloc) => bloc.add(GetSpells()),
      expect: () => [
        GetSpellsBusy(),
        isA<GetSpellsSuccess>()
            .having((state) => state.spells.first.name, 'name', 'Expelliarmus'),
      ],
    );

    // Test for failed fetch of spells
    blocTest<SpellsBloc, SpellsStates>(
      'emits [GetSpellsBusy, GetSpellsError] when GetSpells is added and fetch fails',
      build: () {
        // Mock a failed API response
        when(mockClient
                .get(Uri.parse("https://wizard-world-api.herokuapp.com/Spells")))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        return SpellsBloc(client: mockClient);
      },
      act: (bloc) => bloc.add(GetSpells()),
      expect: () => [
        GetSpellsBusy(),
        isA<GetSpellsError>()
            .having((state) => state.message, 'message', 'Failed to fetch spells'),
      ],
    );

    // Test to ensure no state is emitted if spellsFetched is true
    blocTest<SpellsBloc, SpellsStates>(
      'does not emit any state when spellsFetched is true',
      build: () {
        final spellsBloc = SpellsBloc(client: mockClient);
        spellsBloc.spellsFetched = true;
        return spellsBloc;
      },
      act: (bloc) => bloc.add(GetSpells()),
      expect: () => [],
    );

    // Test for network error during fetch of spells
    blocTest<SpellsBloc, SpellsStates>(
      'emits [GetSpellsBusy, GetSpellsError] when GetSpells is added and a network error occurs',
      build: () {
        // Mock a network error
        when(mockClient
                .get(Uri.parse("https://wizard-world-api.herokuapp.com/Spells")))
            .thenThrow(Exception('Network error'));
        return SpellsBloc(client: mockClient);
      },
      act: (bloc) => bloc.add(GetSpells()),
      expect: () => [
        GetSpellsBusy(),
        isA<GetSpellsError>()
            .having((state) => state.message, 'message', contains('Network error')),
      ],
    );
  });
}
