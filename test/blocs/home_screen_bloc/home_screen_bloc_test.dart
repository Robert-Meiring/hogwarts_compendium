import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hogwarts_compendium/home/home_screen.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_bloc.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_events.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_states.dart';

void main() {
  group('HomeScreenBloc', () {
    // Test for changing tab
    blocTest<HomeScreenBloc, HomeScreenStates>(
      'emits [InitialHomeScreenState, TabChangedState] when TabChanged is added',
      build: () => HomeScreenBloc(),
      act: (bloc) => bloc.add(TabChanged(index: 1)),
      expect: () => [
        isA<InitialHomeScreenState>(),
        TabChangedState(index: 1),
      ],
    );

    // Test for updating search
    blocTest<HomeScreenBloc, HomeScreenStates>(
      'emits [SearchUpdated, TabChangedState] when SearchEvent is added',
      build: () => HomeScreenBloc(),
      act: (bloc) => bloc
          .add(SearchEvent(text: 'search text', tab: TabItem.values[1], index: 1)),
      expect: () => [
        SearchUpdated(text: 'search text', tab: TabItem.values[1], index: 1),
        TabChangedState(index: 1),
      ],
    );

    // Test for sequentially adding TabChanged and SearchEvent
    blocTest<HomeScreenBloc, HomeScreenStates>(
      'emits [InitialHomeScreenState, TabChangedState, SearchUpdated, TabChangedState] when TabChanged and SearchEvent are added sequentially',
      build: () => HomeScreenBloc(),
      act: (bloc) {
        bloc.add(TabChanged(index: 2));
        bloc.add(SearchEvent(text: 'new search', tab: TabItem.values[2], index: 2));
      },
      expect: () => [
        isA<InitialHomeScreenState>(),
        TabChangedState(index: 2),
        SearchUpdated(text: 'new search', tab: TabItem.values[2], index: 2),
        TabChangedState(index: 2),
      ],
    );
  });
}
