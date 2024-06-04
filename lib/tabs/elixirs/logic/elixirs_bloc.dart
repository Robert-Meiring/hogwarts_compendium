import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_compendium/shared/models/elixirs/elixir.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_events.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_states.dart';
import 'package:http/http.dart' as http;

class ElixirsBloc extends Bloc<ElixirsEvents, ElixirsStates> {
  final http.Client client;
  bool elixirsFetched = false;

  ElixirsBloc({required this.client}) : super(InitialElixirsState()) {
    on<GetElixirs>(
      (event, emit) async {
        if (elixirsFetched) return;
        emit(GetElixirsBusy());
        try {
          final Uri uri =
              Uri.parse("https://wizard-world-api.herokuapp.com/Elixirs");
          final response = await client.get(uri);
          if (response.statusCode == 200) {
            final List<dynamic> jsonData = json.decode(response.body);
            List<Elixir> elixirs =
                jsonData.map((houseJson) => Elixir.fromJson(houseJson)).toList();
            elixirsFetched = true;
            emit(GetElixirsSuccess(elixirs: elixirs));
          } else {
            emit(GetElixirsError(message: "Failed to fetch Elixirs"));
          }
        } catch (e) {
          emit(GetElixirsError(message: e.toString()));
        }
      },
    );
  }
}
