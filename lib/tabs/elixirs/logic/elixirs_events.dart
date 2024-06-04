import 'package:equatable/equatable.dart';

// Abstract base class for all elixir-related events
abstract class ElixirsEvents extends Equatable {
  @override
  List<Object> get props => [];
}

// Event to trigger fetching of elixirs
class GetElixirs extends ElixirsEvents {}
