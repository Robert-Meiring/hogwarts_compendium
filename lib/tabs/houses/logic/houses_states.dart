import 'package:equatable/equatable.dart';
import 'package:hogwarts_compendium/shared/models/houses/house.dart';

// Abstract base class for all house-related states
abstract class HousesStates extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial state of the houses
class InitialHousesState extends HousesStates {}

// State when fetching houses is in progress
class GetHousesBusy extends HousesStates {}

// State when fetching houses is successful
class GetHousesSuccess extends HousesStates {
  final List<House> houses;

  GetHousesSuccess({required this.houses});

  @override
  List<Object> get props =>
      [houses]; // Ensure houses list is included in equality checks
}

// State when there is an error fetching houses
class GetHousesError extends HousesStates {
  final String message;

  GetHousesError({required this.message});

  @override
  List<Object> get props =>
      [message]; // Ensure error message is included in equality checks
}
