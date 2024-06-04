import 'package:flutter/material.dart';
import 'package:hogwarts_compendium/home/home_screen.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_bloc.dart';
import 'package:hogwarts_compendium/home/logic/home_screen_events.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/textfields/hogwarts_textfield.dart';

class HogwartsSearchBar extends StatefulWidget {
  const HogwartsSearchBar({super.key, required this.currentTab});
  final TabItem currentTab;

  @override
  State<HogwartsSearchBar> createState() => _HogwartsSearchBarState();
}

class _HogwartsSearchBarState extends State<HogwartsSearchBar> {
  final HomeScreenBloc bloc = sl.get<HomeScreenBloc>();

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen for changes in the text field and dispatch search events
    textController.addListener(() {
      bloc.add(SearchEvent(
          text: textController.text,
          tab: widget.currentTab,
          index: widget.currentTab.index));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: HogwartsTextfield(
            hintText: widget.currentTab == TabItem.spells
                ? 'Search spells...'
                : 'Search elixirs...', // Set hint text based on the current tab
            controller: textController,
          ),
        ),
        const Divider(
          color: HogwartsStyle.foreground,
          height: 1,
        ),
      ],
    );
  }
}
