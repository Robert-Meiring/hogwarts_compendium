import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hogwarts_compendium/home/home_screen.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_bloc.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_states.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/models/elixirs/elixir.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/text/hogwarts_text.dart';

// ignore: must_be_immutable
class ElixirsListview extends StatelessWidget {
  ElixirsListview({super.key, required this.elixirs});
  final List<Elixir> elixirs;
  String filterCriteria = '';
  final HomeScreenBloc filterBloc = sl.get<HomeScreenBloc>();

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    // BlocConsumer listens to changes in the HomeScreenBloc
    return BlocConsumer<HomeScreenBloc, HomeScreenStates>(
        bloc: filterBloc,
        listener: (context, state) {
          // Update filter criteria when the search text changes
          if (state is SearchUpdated && state.tab == TabItem.elixirs) {
            filterCriteria = state.text;
          }
        },
        builder: (context, state) {
          return ListView.builder(
              itemCount: elixirs.length,
              physics:
                  const BouncingScrollPhysics(), // Bouncy scroll physics for the list view
              itemBuilder: (context, index) {
                final elixir = elixirs[index];

                // Check if the elixir matches the filter criteria
                final containsFilterCriteria = elixir.name
                        .toLowerCase()
                        .contains(filterCriteria.toLowerCase()) ||
                    (elixir.effect?.toLowerCase().contains(filterCriteria.toLowerCase()) ??
                        false) ||
                    (elixir.sideEffects
                            ?.toLowerCase()
                            .contains(filterCriteria.toLowerCase()) ??
                        false) ||
                    (elixir.characteristics
                            ?.toLowerCase()
                            .contains(filterCriteria.toLowerCase()) ??
                        false) ||
                    (elixir.time?.toLowerCase().contains(filterCriteria.toLowerCase()) ??
                        false) ||
                    elixir.difficulty
                        .toLowerCase()
                        .contains(filterCriteria.toLowerCase()) ||
                    (elixir.manufacturer
                            ?.toLowerCase()
                            .contains(filterCriteria.toLowerCase()) ??
                        false) ||
                    elixir.ingredients.any((ingredient) => ingredient.name
                        .toLowerCase()
                        .contains(filterCriteria.toLowerCase()));

                // Only display elixirs that match the filter criteria
                return containsFilterCriteria
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: HogwartsStyle.backgroundAlt,
                          borderRadius: HogwartsStyle.borderRadius,
                          child: InkWell(
                            onTap: () {
                              // Navigate to detail view when an elixir is tapped
                              Navigator.pushNamed(context, '/detailView',
                                  arguments: {
                                    'data': elixirs[index],
                                    'image': 'assets/icons/potion.svg',
                                  });
                            },
                            borderRadius: HogwartsStyle.borderRadius,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      HogwartsText(
                                        text: elixirs[index].name.toUpperCase(),
                                        fontScale: 1.5,
                                      ),
                                      elixirs[index].difficulty != 'Unknown'
                                          ? HogwartsText(
                                              text: elixirs[index]
                                                  .difficulty
                                                  .toUpperCase(),
                                              altColor: true,
                                              fontScale: 1.3,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    'assets/icons/potion.svg',
                                    width: screenW / 10,
                                    colorFilter: const ColorFilter.mode(
                                        HogwartsStyle.foreground, BlendMode.srcIn),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container();
              });
        });
  }
}
