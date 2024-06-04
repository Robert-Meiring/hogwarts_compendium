import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_bloc.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_events.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_states.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'houses_bloc_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  // Set up a new instance of MockClient before each test
  setUp(() {
    mockClient = MockClient();
  });

  group('HousesBloc', () {
    // Test to verify the initial state of HousesBloc
    test('initial state is InitialHousesState', () {
      final housesBloc = HousesBloc(client: mockClient);
      expect(housesBloc.state, InitialHousesState());
    });

    // Test for successful fetch of houses
    blocTest<HousesBloc, HousesStates>(
      'emits [GetHousesBusy, GetHousesSuccess] when GetHouses is added and fetch is successful',
      build: () {
        // Mock a successful API response
        when(mockClient
                .get(Uri.parse("https://wizard-world-api.herokuapp.com/Houses")))
            .thenAnswer((_) async => http.Response(
                json.encode([
                  {
                    "id": "1",
                    "name": "Gryffindor",
                    "houseColours": "Scarlet and Gold",
                    "founder": "Godric Gryffindor",
                    "animal": "Lion",
                    "element": "Fire",
                    "ghost": "Nearly Headless Nick",
                    "commonRoom": "Gryffindor Tower",
                    "heads": [],
                    "traits": []
                  }
                ]),
                200));
        return HousesBloc(client: mockClient);
      },
      act: (bloc) => bloc.add(GetHouses()),
      expect: () => [
        GetHousesBusy(),
        isA<GetHousesSuccess>()
            .having((state) => state.houses.first.name, 'name', 'Gryffindor'),
      ],
    );

    // Test for failed fetch of houses
    blocTest<HousesBloc, HousesStates>(
      'emits [GetHousesBusy, GetHousesError] when GetHouses is added and fetch fails',
      build: () {
        // Mock a failed API response
        when(mockClient
                .get(Uri.parse("https://wizard-world-api.herokuapp.com/Houses")))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        return HousesBloc(client: mockClient);
      },
      act: (bloc) => bloc.add(GetHouses()),
      expect: () => [
        GetHousesBusy(),
        isA<GetHousesError>()
            .having((state) => state.message, 'message', 'Failed to fetch houses'),
      ],
    );

    // Test to ensure no state is emitted if housesFetched is true
    blocTest<HousesBloc, HousesStates>(
      'does not emit any state when housesFetched is true',
      build: () {
        final housesBloc = HousesBloc(client: mockClient);
        housesBloc.housesFetched = true;
        return housesBloc;
      },
      act: (bloc) => bloc.add(GetHouses()),
      expect: () => [],
    );

    // Test for network error during fetch of houses
    blocTest<HousesBloc, HousesStates>(
      'emits [GetHousesBusy, GetHousesError] when GetHouses is added and a network error occurs',
      build: () {
        // Mock a network error
        when(mockClient
                .get(Uri.parse("https://wizard-world-api.herokuapp.com/Houses")))
            .thenThrow(Exception('Network error'));
        return HousesBloc(client: mockClient);
      },
      act: (bloc) => bloc.add(GetHouses()),
      expect: () => [
        GetHousesBusy(),
        isA<GetHousesError>()
            .having((state) => state.message, 'message', contains('Network error')),
      ],
    );
  });
}
