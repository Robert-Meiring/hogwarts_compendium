import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hogwarts_compendium/detail_view/widgets/dynamic_builder.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'package:hogwarts_compendium/shared/widgets/text/hogwarts_text.dart';

class DetailViewScreen extends StatelessWidget {
  const DetailViewScreen({super.key, required this.imagePath, required this.data});
  final String? imagePath;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: HogwartsStyle.background,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            // Header section with a back button and optional image
            Material(
              color: HogwartsStyle.backgroundAlt,
              child: InkWell(
                onTap: () => Navigator.pop(context), // Navigate back on tap
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chevron_left,
                        size: screenW / 8,
                        color: HogwartsStyle.foreground,
                      ),
                      const HogwartsText(
                        text: 'DETAILS',
                        fontScale: 2,
                        altColor: true,
                      ),
                      const Spacer(),
                      imagePath != null
                          ? SvgPicture.asset(
                              imagePath!,
                              width: screenW / 8,
                              colorFilter: imagePath!.contains('wand') ||
                                      imagePath!.contains('potion')
                                  ? const ColorFilter.mode(
                                      HogwartsStyle.foreground, BlendMode.srcIn)
                                  : null,
                            )
                          : Container() // Display image if available
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              // Content section with dynamic data
              child: SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(), // Bouncy scroll physics for better UX
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DynamicBuilder(
                      data: data), // Build dynamic content based on the data
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
