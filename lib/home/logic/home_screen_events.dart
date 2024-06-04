import 'package:equatable/equatable.dart';
import 'package:hogwarts_compendium/home/home_screen.dart';

abstract class HomeScreenEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class TabChanged extends HomeScreenEvents {
  final int index;

  TabChanged({required this.index});

  @override
  List<Object> get props => [index]; // Ensure index is included in equality checks
}

class SearchEvent extends HomeScreenEvents {
  final String text;
  final TabItem tab;
  final int index;

  SearchEvent({required this.text, required this.tab, required this.index});

  @override
  List<Object> get props =>
      [text, tab, index]; // Ensure all fields are included in equality checks
}
