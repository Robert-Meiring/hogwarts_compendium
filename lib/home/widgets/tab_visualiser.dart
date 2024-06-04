import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_compendium/home/home_screen.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_bloc.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_states.dart';
import 'package:hogwarts_compendium/home/widgets/hogwarts_search_bar.dart';
import 'package:hogwarts_compendium/home/widgets/tab_title.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/animators/hogwarts_size_animation.dart';

class TabVisualiser extends StatelessWidget {
  TabVisualiser({super.key});
  final HomeScreenBloc bloc = sl.get<HomeScreenBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenStates>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: [
              // Divider line between the tabs and the content
              const Divider(
                color: HogwartsStyle.foreground,
                height: 1,
              ),
              // Row containing the tab titles
              Row(
                children: List.generate(3, (index) {
                  return TabTitle(
                      title: TabItem.values[index].name,
                      currentlySelected:
                          state is TabChangedState && state.index == index
                              ? true
                              : false);
                }),
              ),
              const Divider(
                color: HogwartsStyle.foreground,
                height: 1,
              ),
              // Animated widget to display search bar based on the selected tab
              HogwartsSizeAnimation(
                  child: state is TabChangedState && state.index > 0
                      ? HogwartsSearchBar(
                          currentTab: TabItem.values[state.index],
                          key: Key(state.index.toString()),
                        )
                      : Container())
            ],
          );
        });
  }
}
