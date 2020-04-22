import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:my_fit/common/auth-interceptor.dart';
import 'package:my_fit/models/favorites.dart';
import 'package:my_fit/models/training.dart';
import 'package:my_fit/screens/favorites-page.dart';
import 'package:my_fit/screens/home-page.dart';
import 'package:my_fit/screens/login-page.dart';
import 'package:my_fit/screens/registration-page.dart';
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
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        return MaterialApp(
            title: 'My Fit app',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData.dark(),
            initialRoute: '/',
            routes: {
              '/': (context) => _buildMainRoute(context, value.user),
              '/login': _buildLoginPage,
              '/registration': (context) => RegistrationPage(),
              '/favorites': (context) {
                final favoritesPageClient =
                    HttpClientWithInterceptor.build(interceptors: [
                  AuthInterceptor(value.user),
                ]);
                return _buildFavoriteItemsPage(favoritesPageClient);
              }
            });
      },
    );
  }

  Widget _buildMainRoute(BuildContext context, User user) {
    if (user == null) {
      return _buildLoginPage(context);
    }

    final homePageClient = HttpClientWithInterceptor.build(interceptors: [
      AuthInterceptor(user),
    ]);
    return _buildHomePage(homePageClient);
  }

  Widget _buildLoginPage(BuildContext context) {
    return LoginPage();
  }

  /// Get list of global providers.
  List<SingleChildCloneableWidget> _getGlobalProviders() {
    return [
      ChangeNotifierProvider(create: (context) => UserModel()),
    ];
  }

  /// Build home page.
  Widget _buildHomePage(Client client) {
    return ChangeNotifierProvider(
      child: HomePage(),
      create: (BuildContext context) => TrainingModel(
        httpClient: client,
      ),
    );
  }

  /// Favorites page.
  Widget _buildFavoriteItemsPage(Client client) {
    return ChangeNotifierProvider(
      child: FavoritesPage(),
      create: (BuildContext context) => FavoritesModel(
        httpClient: client,
      ),
    );
  }
}
