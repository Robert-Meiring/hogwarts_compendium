import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_bloc.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_events.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_states.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'elixirs_bloc_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  group('ElixirsBloc', () {
    test('initial state is InitialElixirsState', () {
      // Test to check the initial state of ElixirsBloc
      final elixirsBloc = ElixirsBloc(client: mockClient);
      expect(elixirsBloc.state, InitialElixirsState());
    });

    blocTest<ElixirsBloc, ElixirsStates>(
      'emits [GetElixirsBusy, GetElixirsSuccess] when GetElixirs is added and fetch is successful',
      build: () {
        // Mock a successful API response
        when(mockClient
                .get(Uri.parse("https://wizard-world-api.herokuapp.com/Elixirs")))
            .thenAnswer((_) async => http.Response(
                json.encode([
                  {
                    "id": "1",
                    "name": "Felix Felicis",
                    "effect": "Luck",
                    "sideEffects": "Overconfidence",
                    "characteristics": "Golden",
                    "time": "Brewed for 6 months",
                    "difficulty": "Advanced",
                    "ingredients": [],
                    "inventors": [],
                    "manufacturer": "Slughorn"
                  }
                ]),
                200));
        return ElixirsBloc(client: mockClient);
      },
      act: (bloc) => bloc.add(GetElixirs()),
      expect: () => [
        // Expect these states to be emitted
        GetElixirsBusy(),
        isA<GetElixirsSuccess>()
            .having((state) => state.elixirs.first.name, 'name', 'Felix Felicis'),
      ],
    );

    blocTest<ElixirsBloc, ElixirsStates>(
      'emits [GetElixirsBusy, GetElixirsError] when GetElixirs is added and fetch fails',
      build: () {
        // Mock a failed API response
        when(mockClient
                .get(Uri.parse("https://wizard-world-api.herokuapp.com/Elixirs")))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        return ElixirsBloc(client: mockClient);
      },
      act: (bloc) => bloc.add(GetElixirs()),
      expect: () => [
        // Expect these states to be emitted
        GetElixirsBusy(),
        isA<GetElixirsError>()
            .having((state) => state.message, 'message', 'Failed to fetch Elixirs'),
      ],
    );

    blocTest<ElixirsBloc, ElixirsStates>(
      'does not emit any state when elixirsFetched is true',
      build: () {
        // Ensure no state is emitted if elixirsFetched is true
        final elixirsBloc = ElixirsBloc(client: mockClient);
        elixirsBloc.elixirsFetched = true;
        return elixirsBloc;
      },
      act: (bloc) => bloc.add(GetElixirs()),
      expect: () => [],
    );

    blocTest<ElixirsBloc, ElixirsStates>(
      'emits [GetElixirsBusy, GetElixirsError] when GetElixirs is added and a network error occurs',
      build: () {
        // Mock a network error
        when(mockClient
                .get(Uri.parse("https://wizard-world-api.herokuapp.com/Elixirs")))
            .thenThrow(Exception('Network error'));
        return ElixirsBloc(client: mockClient);
      },
      act: (bloc) => bloc.add(GetElixirs()),
      expect: () => [
        // Expect these states to be emitted
        GetElixirsBusy(),
        isA<GetElixirsError>()
            .having((state) => state.message, 'message', contains('Network error')),
      ],
    );
  });
}
