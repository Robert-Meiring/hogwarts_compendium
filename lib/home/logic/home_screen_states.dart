import 'package:equatable/equatable.dart';
import 'package:hogwarts_compendium/home/home_screen.dart';

abstract class HomeScreenStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialHomeScreenState extends HomeScreenStates {}

class TabChangedState extends HomeScreenStates {
  final int index;

  TabChangedState({required this.index});

  @override
  List<Object> get props => [index]; // Ensure index is included in equality checks
}

class SearchUpdated extends HomeScreenStates {
  final String text;
  final TabItem tab;
  final int index;

  SearchUpdated({
    required this.text,
    required this.tab,
    required this.index,
  });

  @override
  List<Object> get props =>
      [text, tab, index]; // Ensure all fields are included in equality checks
}
