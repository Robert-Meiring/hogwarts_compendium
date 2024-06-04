import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/widgets/animators/hogwarts_scale_animation.dart';
import 'package:hogwarts_compendium/shared/widgets/error_handling/hogwarts_snackbars.dart';
import 'package:hogwarts_compendium/shared/widgets/loaders/hogwarts_loader.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_bloc.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_states.dart';
import 'package:hogwarts_compendium/tabs/elixirs/widgets/elixirs_listview.dart';

class ElixirsTab extends StatelessWidget {
  ElixirsTab({super.key});
  final ElixirsBloc bloc = sl.get<ElixirsBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElixirsBloc, ElixirsStates>(
      bloc: bloc,
      listener: (context, state) {
        // Show error snackbar if there is an error fetching elixirs
        if (state is GetElixirsError) {
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

  Widget _buildStateContent(ElixirsStates state) {
    // Handle different states of fetching elixirs
    switch (state) {
      case InitialElixirsState():
      case GetElixirsBusy():
        return const Center(
            child: HogwartsLoader()); // Show loader for initial and busy states
      case GetElixirsSuccess():
        return ElixirsListview(
            elixirs: state.elixirs); // Show elixirs list on success
      default:
        return const Center(
            child: HogwartsLoader()); // Show loader for any other unexpected state
    }
  }
}
