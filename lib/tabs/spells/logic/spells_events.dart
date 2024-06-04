import 'package:equatable/equatable.dart';

// Abstract base class for all spell-related events
abstract class SpellsEvents extends Equatable {
  @override
  List<Object> get props => [];
}

// Event to trigger fetching of spells
class GetSpells extends SpellsEvents {}
