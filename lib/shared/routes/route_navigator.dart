import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hogwarts_compendium/detail_view/detail_view_screen.dart';
import 'package:hogwarts_compendium/home/home_screen.dart';

class RouteNavigator {
  static const String home = '/';
  static const String detailView = '/detailView';

  // Method to generate routes based on the route settings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        // Route for the home screen
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case detailView:
        // Route for the detail view screen
        if (settings.arguments == null) {
          return _errorRoute(); // Show error route if no arguments are provided
        } else {
          final args = settings.arguments as Map<String, dynamic>;
          final data = args['data'];
          final imagePath = args['image'];
          return MaterialPageRoute(
              builder: (_) => DetailViewScreen(
                    data: json.decode(json.encode(
                        data)), // Decode and re-encode data to ensure it's a Map
                    imagePath: imagePath,
                  ));
        }
      default:
        // Show error route for undefined routes
        return _errorRoute();
    }
  }

  // Method to generate an error route
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}
