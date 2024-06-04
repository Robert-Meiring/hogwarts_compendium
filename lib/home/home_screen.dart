import 'package:flutter/material.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_bloc.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_events.dart';
import 'package:hogwarts_compendium/home/widgets/tab_visualiser.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/text/hogwarts_text.dart';
import 'package:hogwarts_compendium/tabs/elixirs/elixirs_tab.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_bloc.dart';
import 'package:hogwarts_compendium/tabs/elixirs/logic/elixirs_events.dart';
import 'package:hogwarts_compendium/tabs/houses/houses_tab.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_bloc.dart';
import 'package:hogwarts_compendium/tabs/houses/logic/houses_events.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_bloc.dart';
import 'package:hogwarts_compendium/tabs/spells/logic/spells_events.dart';
import 'package:hogwarts_compendium/tabs/spells/spells_tab.dart';

enum TabItem { houses, spells, elixirs }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final HomeScreenBloc bloc = sl.get<HomeScreenBloc>();

  @override
  void initState() {
    super.initState();

    // Initialize the tab controller with the number of tabs
    tabController = TabController(
      length: TabItem.values.length,
      vsync: this,
    );

    // Add listener to handle tab changes
    tabController.addListener(_onTabChanged);
    _onTabChanged();
  }

  void _onTabChanged() {
    final currentTab = TabItem.values[tabController.index];

    // Dispatch an event to notify about the tab change
    bloc.add(TabChanged(index: tabController.index));

    // Handle fetching data based on the current tab
    switch (currentTab) {
      case TabItem.houses:
        final housesBloc = sl.get<HousesBloc>();
        if (!housesBloc.housesFetched) {
          housesBloc.add(GetHouses());
        }
        break;
      case TabItem.elixirs:
        final elixirsBloc = sl.get<ElixirsBloc>();
        if (!elixirsBloc.elixirsFetched) {
          elixirsBloc.add(GetElixirs());
        }
        break;
      case TabItem.spells:
        final spellsBloc = sl.get<SpellsBloc>();
        if (!spellsBloc.spellsFetched) {
          spellsBloc.add(GetSpells());
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HogwartsStyle.background,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: HogwartsText(
                text: 'Hogwarts Compendium',
                fontScale: 2.5,
              ),
            ),

            // Widget to visualize the selected tab
            TabVisualiser(),

            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const BouncingScrollPhysics(),

                // Generate the tab views based on the current tab index
                children: List.generate(TabItem.values.length, (index) {
                  switch (TabItem.values[index]) {
                    case TabItem.houses:
                      return HousesTab();
                    case TabItem.elixirs:
                      return ElixirsTab();
                    case TabItem.spells:
                      return SpellsTab();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
