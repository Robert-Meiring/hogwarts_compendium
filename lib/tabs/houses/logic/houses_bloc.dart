import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_compendium/shared/models/houses/house.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_events.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_states.dart';
import 'package:http/http.dart' as http;

class HousesBloc extends Bloc<HousesEvents, HousesStates> {
  final http.Client client;
  bool housesFetched = false;

  HousesBloc({required this.client}) : super(InitialHousesState()) {
    on<GetHouses>(
      (event, emit) async {
        if (housesFetched) return;
        emit(GetHousesBusy());
        try {
          final Uri uri = Uri.parse("https://wizard-world-api.herokuapp.com/Houses");
          final response = await client.get(uri);
          if (response.statusCode == 200) {
            final List<dynamic> jsonData = json.decode(response.body);
            List<House> houses =
                jsonData.map((houseJson) => House.fromJson(houseJson)).toList();
            housesFetched = true;
            emit(GetHousesSuccess(houses: houses));
          } else {
            emit(GetHousesError(message: "Failed to fetch houses"));
          }
        } catch (e) {
          emit(GetHousesError(message: e.toString()));
        }
      },
    );
  }
}
