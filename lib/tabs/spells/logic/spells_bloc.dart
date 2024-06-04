import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_compendium/shared/models/spells/spell.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_events.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_states.dart';
import 'package:http/http.dart' as http;

class SpellsBloc extends Bloc<SpellsEvents, SpellsStates> {
  final http.Client client;
  bool spellsFetched = false;

  SpellsBloc({required this.client}) : super(InitialSpellsState()) {
    on<GetSpells>(
      (event, emit) async {
        if (spellsFetched) return;
        emit(GetSpellsBusy());
        try {
          final Uri uri = Uri.parse("https://wizard-world-api.herokuapp.com/Spells");
          final response = await client.get(uri);
          if (response.statusCode == 200) {
            final List<dynamic> jsonData = json.decode(response.body);
            List<Spell> spells =
                jsonData.map((spellsJson) => Spell.fromJson(spellsJson)).toList();
            spellsFetched = true;
            emit(GetSpellsSuccess(spells: spells));
          } else {
            emit(GetSpellsError(message: "Failed to fetch spells"));
          }
        } catch (e) {
          emit(GetSpellsError(message: e.toString()));
        }
      },
    );
  }
}
