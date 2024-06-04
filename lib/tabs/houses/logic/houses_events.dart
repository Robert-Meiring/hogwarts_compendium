import 'package:equatable/equatable.dart';

// Abstract base class for all house-related events
abstract class HousesEvents extends Equatable {
  @override
  List<Object> get props => [];
}

// Event to trigger fetching of houses
class GetHouses extends HousesEvents {}
