import 'package:flutter/material.dart';
import 'package:my_fit/favorites-page.dart';

import '../home-page.dart';
import '../login-page.dart';

class MyFitMainDrawer extends StatelessWidget {
  MyFitMainDrawer(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          _buildDrawerHeader(context),
          ..._buildNavigationList(context),
        ],
      ),
    );
  }

  DrawerHeader _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<ListTile> _buildNavigationList(BuildContext context) {
    return [
      ListTile(
        title: Text('Home page'),
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        ),
      ),
      ListTile(
        title: Text('Favorites'),
        leading: Icon(Icons.favorite),
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => FavoritesPage(),
          ),
        ),
      )
    ];
  }
}
