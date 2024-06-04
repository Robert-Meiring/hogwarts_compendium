import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/widgets/animators/hogwarts_scale_animation.dart';
import 'package:hogwarts_compendium/shared/widgets/error_handling/hogwarts_snackbars.dart';
import 'package:hogwarts_compendium/shared/widgets/loaders/hogwarts_loader.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_bloc.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_states.dart';
import 'package:hogwarts_compendium/tabs/spells/widgets/spells_listview.dart';

class SpellsTab extends StatelessWidget {
  SpellsTab({super.key});
  final SpellsBloc bloc = sl.get<SpellsBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpellsBloc, SpellsStates>(
      bloc: bloc,
      listener: (context, state) {
        if (state is GetSpellsError) {
          HogwartsSnackbars.showErrorSnackbar(
              context, state.message); // Show error snackbar on error state
        }
      },
      builder: (context, state) {
        return HogwartsScaleAnimation(
          child: _buildStateContent(state), // Build content based on the state
        );
      },
    );
  }

  Widget _buildStateContent(SpellsStates state) {
    switch (state) {
      case InitialSpellsState():
      case GetSpellsBusy():
        return const Center(
            child: HogwartsLoader()); // Show loader for initial and busy states
      case GetSpellsSuccess():
        return SpellsListview(
            spells: state.spells); // Show list of spells on success
      default:
        return const Center(
            child: HogwartsLoader()); // Show loader for any other unexpected state
    }
  }
}
