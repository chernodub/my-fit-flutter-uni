import 'package:flutter/material.dart';
import 'package:my_fit/home-page.dart';
import 'package:provider/provider.dart';

import 'models/user.model.dart';

void main() => runApp(MyFitApp());

class MyFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: _buildMaterialAppWithPage(HomePage()),
      providers: _getGlobalProviders(),
    );
  }

  /// Build material app with page.
  Widget _buildMaterialAppWithPage(Widget page) {
    return MaterialApp(
      title: 'My Fit app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: page,
    );
  }

  /// Get list of global providers.
  List<SingleChildCloneableWidget> _getGlobalProviders() {
    return [
      ChangeNotifierProvider(create: (context) => UserModel()),
    ];
  }
}
