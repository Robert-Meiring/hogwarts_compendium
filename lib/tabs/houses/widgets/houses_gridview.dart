import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hogwarts_compendium/shared/models/houses/house.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/text/hogwarts_text.dart';

class HousesGridview extends StatelessWidget {
  const HousesGridview({super.key, required this.houses});
  final List<House> houses;

  // Method to get the SVG image of a house
  SvgPicture getHouseImage(String houseName) {
    return SvgPicture.asset(
      'assets/logos/${houseName.toLowerCase()}.svg',
      width: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: houses.length,
      physics:
          const BouncingScrollPhysics(), // Bouncy scroll physics for the grid view
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display two items per row
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: HogwartsStyle.backgroundAlt,
          borderRadius: HogwartsStyle.borderRadius,
          child: InkWell(
            onTap: () {
              // Navigate to detail view when a house item is tapped
              Navigator.pushNamed(context, '/detailView', arguments: {
                'data': houses[index],
                'image': 'assets/logos/${houses[index].name.toLowerCase()}.svg',
              });
            },
            borderRadius: HogwartsStyle.borderRadius,
            child: Stack(
              children: [
                getHouseImage(houses[index].name), // Display the house image
                Center(
                  child: Container(
                    width: double.infinity,
                    color: HogwartsStyle.backgroundAlt.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HogwartsText(
                        text: houses[index].name.toUpperCase(),
                        altColor: false,
                        fontScale: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
