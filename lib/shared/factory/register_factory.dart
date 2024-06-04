import 'package:get_it/get_it.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_bloc.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_bloc.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_bloc.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

class RegisterFactory {
  Future<void> setup() async {
    // Register the HTTP client
    sl.registerLazySingleton<http.Client>(() => http.Client());

    // Register the BLoCs with the HTTP client
    sl.registerLazySingleton<HomeScreenBloc>(() => HomeScreenBloc());
    sl.registerLazySingleton<HousesBloc>(() => HousesBloc(client: sl<http.Client>()));
    sl.registerLazySingleton<SpellsBloc>(() => SpellsBloc(client: sl<http.Client>()));
    sl.registerLazySingleton<ElixirsBloc>(() => ElixirsBloc(client: sl<http.Client>()));
  }
}
