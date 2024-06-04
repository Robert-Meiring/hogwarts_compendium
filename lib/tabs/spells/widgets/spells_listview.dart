import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hogwarts_compendium/home/home_screen.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_bloc.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_states.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/models/spells/spell.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/text/hogwarts_text.dart';

// ignore: must_be_immutable
class SpellsListview extends StatelessWidget {
  SpellsListview({super.key, required this.spells});
  final List<Spell> spells;
  final HomeScreenBloc filterBloc = sl.get<HomeScreenBloc>();
  String filterCriteria = '';

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    // BlocConsumer listens to changes in the HomeScreenBloc
    return BlocConsumer<HomeScreenBloc, HomeScreenStates>(
        bloc: filterBloc,
        listener: (context, state) {
          // Update filter criteria when the search text changes
          if (state is SearchUpdated && state.tab == TabItem.spells) {
            filterCriteria = state.text;
          }
        },
        builder: (context, state) {
          return ListView.builder(
              itemCount: spells.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final spell = spells[index];

                // Check if the spell matches the filter criteria
                final containsFilterCriteria = spell.name
                        .toLowerCase()
                        .contains(filterCriteria.toLowerCase()) ||
                    (spell.incantation
                            ?.toLowerCase()
                            .contains(filterCriteria.toLowerCase()) ??
                        false) ||
                    spell.effect
                        .toLowerCase()
                        .contains(filterCriteria.toLowerCase()) ||
                    spell.type
                        .toLowerCase()
                        .contains(filterCriteria.toLowerCase()) ||
                    spell.light
                        .toLowerCase()
                        .contains(filterCriteria.toLowerCase()) ||
                    (spell.creator
                            ?.toLowerCase()
                            .contains(filterCriteria.toLowerCase()) ??
                        false);

                // Only display spells that match the filter criteria
                return containsFilterCriteria
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: HogwartsStyle.backgroundAlt,
                          borderRadius: HogwartsStyle.borderRadius,
                          child: InkWell(
                            onTap: () {
                              // Navigate to detail view when a spell is tapped
                              Navigator.pushNamed(context, '/detailView',
                                  arguments: {
                                    'data': spell,
                                    'image': 'assets/icons/wand.svg',
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
                                        text: spell.name.toUpperCase(),
                                        fontScale: 1.5,
                                      ),
                                      spell.incantation != null
                                          ? HogwartsText(
                                              text: spell.incantation!.toUpperCase(),
                                              altColor: true,
                                              fontScale: 1.3,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    'assets/icons/wand.svg',
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
