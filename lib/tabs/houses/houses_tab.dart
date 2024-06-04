import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/widgets/animators/hogwarts_scale_animation.dart';
import 'package:hogwarts_compendium/shared/widgets/error_handling/hogwarts_snackbars.dart';
import 'package:hogwarts_compendium/shared/widgets/loaders/hogwarts_loader.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_bloc.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_states.dart';
import 'package:hogwarts_compendium/tabs/houses/widgets/houses_gridview.dart';

class HousesTab extends StatelessWidget {
  HousesTab({super.key});
  final HousesBloc bloc = sl.get<HousesBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HousesBloc, HousesStates>(
      bloc: bloc,
      listener: (context, state) {
        // Show error snackbar if there is an error fetching houses
        if (state is GetHousesError) {
          HogwartsSnackbars.showErrorSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        return HogwartsScaleAnimation(
          child:
              _buildStateContent(state), // Build content based on the current state
        );
      },
    );
  }

  Widget _buildStateContent(HousesStates state) {
    // Handle different states of fetching houses
    switch (state) {
      case InitialHousesState():
      case GetHousesBusy():
        return const Center(
            child: HogwartsLoader()); // Show loader for initial and busy states
      case GetHousesSuccess():
        return HousesGridview(houses: state.houses); // Show houses grid on success
      default:
        return const Center(
            child: HogwartsLoader()); // Show loader for any other unexpected state
    }
  }
}
