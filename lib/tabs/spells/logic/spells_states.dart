import 'package:equatable/equatable.dart';
import 'package:hogwarts_compendium/shared/models/spells/spell.dart';

// Abstract base class for all spell-related states
abstract class SpellsStates extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial state of the spells
class InitialSpellsState extends SpellsStates {}

// State when fetching spells is in progress
class GetSpellsBusy extends SpellsStates {}

// State when fetching spells is successful
class GetSpellsSuccess extends SpellsStates {
  final List<Spell> spells;

  GetSpellsSuccess({required this.spells});

  @override
  List<Object> get props =>
      [spells]; // Ensure spells list is included in equality checks
}

// State when there is an error fetching spells
class GetSpellsError extends SpellsStates {
  final String message;

  GetSpellsError({required this.message});

  @override
  List<Object> get props =>
      [message]; // Ensure error message is included in equality checks
}
