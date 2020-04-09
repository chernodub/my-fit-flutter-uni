import 'package:flutter/material.dart';
import 'package:my_fit/favorites-page.dart';
import 'package:my_fit/home-page.dart';
import 'package:my_fit/login-page.dart';
import 'package:my_fit/models/favorites.dart';
import 'package:my_fit/models/training.dart';
import 'package:my_fit/registration-page.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyFitApp());

class MyFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: _buildMaterialApp(),
      providers: _getGlobalProviders(),
    );
  }

  /// Build material app with page.
  Widget _buildMaterialApp() {
    return MaterialApp(
        title: 'My Fit app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => _buildHomePage(),
          '/login': (context) => LoginPage(),
          '/registration': (context) => RegistrationPage(),
          '/favorites': (context) => _buildFavoriteItemsPage(),
        });
  }

  /// Get list of global providers.
  List<SingleChildCloneableWidget> _getGlobalProviders() {
    return [
      ChangeNotifierProvider(create: (context) => UserModel()),
    ];
  }

  /// Build home page.
  Widget _buildHomePage() {
    return ChangeNotifierProvider(
      child: HomePage(),
      create: (BuildContext context) => TrainingModel(),
    );
  }

  /// Favorites page.
  Widget _buildFavoriteItemsPage() {
    return ChangeNotifierProvider(
      child: FavoritesPage(),
      create: (BuildContext context) => FavoritesModel(),
    );
  }
}
