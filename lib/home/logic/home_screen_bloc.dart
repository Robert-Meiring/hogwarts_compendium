import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_events.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_states.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvents, HomeScreenStates> {
  HomeScreenBloc() : super(InitialHomeScreenState()) {
    on<TabChanged>(
      (event, emit) async {
        emit(InitialHomeScreenState()); // Reset state to initial state on tab change
        emit(TabChangedState(
            index: event.index)); // Emit new state with updated tab index
      },
    );
    on<SearchEvent>(
      (event, emit) async {
        emit(SearchUpdated(
            text: event.text,
            tab: event.tab,
            index: event.index)); // Emit search updated state
        emit(TabChangedState(
            index: event
                .index)); // Re-emit tab changed state to ensure UI reflects the search update
      },
    );
  }
}
