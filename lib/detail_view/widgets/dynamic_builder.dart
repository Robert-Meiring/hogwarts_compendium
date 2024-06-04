import 'package:flutter/material.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/text/hogwarts_text.dart';

class DynamicBuilder extends StatelessWidget {
  const DynamicBuilder({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return buildMapData(data, 0);
  }

  // Recursive method to build widgets for the given map data
  Widget buildMapData(Map<String, dynamic> data, int level) {
    if (data.isEmpty) {
      return const HogwartsText(text: "No data available");
    }

    List<Widget> children = [];
    data.forEach((key, value) {
      if (key != "id") {
        // Skip the 'id' key
        if (value is String) {
          children.add(buildMapDataItem(key, value, level));
        } else if (value is Map) {
          children.add(buildExpandedSection(
              key, buildMapData(value as Map<String, dynamic>, level + 1)));
        } else if (value is List) {
          children.add(buildMapDataList(key, value, level));
        }
      }
    });

    return Column(children: children);
  }

  // Method to build a widget for a single key-value pair
  Widget buildMapDataItem(String key, String value, int level) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: HogwartsText(
          text: ("$key: $value").toUpperCase(),
          fontScale: 1.5,
        ),
      ),
    );
  }

  // Method to build a section for nested maps
  Widget buildExpandedSection(String key, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: HogwartsStyle.backgroundAlt,
        borderRadius: HogwartsStyle.borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }

  // Method to build a section for lists
  Widget buildMapDataList(String key, List<dynamic> data, int level) {
    return data.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HogwartsText(
                text: key.toUpperCase(),
                fontScale: 2,
                altColor: true,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (data[index] is String) {
                    return buildMapDataItem(
                        "Item ${index + 1}", data[index] as String, level + 1);
                  } else if (data[index] is Map) {
                    var map = data[index] as Map<String, dynamic>;
                    if (map.keys.contains('id')) {
                      map.remove('id'); // Remove 'id' key if present
                    }
                    return buildExpandedSection(
                        (index + 1).toString(), buildMapData(map, level + 1));
                  } else {
                    return const HogwartsText(
                      text: "Unsupported data type in list",
                    );
                  }
                },
              ),
            ],
          )
        : Container();
  }
}
