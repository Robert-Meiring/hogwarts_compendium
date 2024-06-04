import 'package:equatable/equatable.dart';
import 'package:hogwarts_compendium/shared/models/elixirs/elixir.dart';

// Abstract base class for all elixir-related states
abstract class ElixirsStates extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial state of the elixirs
class InitialElixirsState extends ElixirsStates {}

// State when fetching elixirs is in progress
class GetElixirsBusy extends ElixirsStates {}

// State when fetching elixirs is successful
class GetElixirsSuccess extends ElixirsStates {
  final List<Elixir> elixirs;

  GetElixirsSuccess({required this.elixirs});

  @override
  List<Object> get props =>
      [elixirs]; // Ensure elixirs list is included in equality checks
}

// State when there is an error fetching elixirs
class GetElixirsError extends ElixirsStates {
  final String message;

  GetElixirsError({required this.message});

  @override
  List<Object> get props =>
      [message]; // Ensure error message is included in equality checks
}
