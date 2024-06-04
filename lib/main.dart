import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hogwarts_compendium/shared/factory/register_factory.dart';
import 'package:hogwarts_compendium/shared/style/hogwarts_style.dart';
import 'shared/routes/route_navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the system UI overlay style to dark with a white status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
      .copyWith(statusBarColor: Colors.white, statusBarBrightness: Brightness.dark));

  // Lock the device orientation to portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize necessary components using the RegisterFactory
  await RegisterFactory().setup();

  // Run the main application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hogwarts Compendium',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: HogwartsStyle.accent),
        fontFamily: 'Potter',
        useMaterial3: true,
      ),

      // Define the initial route for the application
      initialRoute: RouteNavigator.home,

      // Generate routes using the custom RouteNavigator
      onGenerateRoute: RouteNavigator.generateRoute,
    );
  }
}
