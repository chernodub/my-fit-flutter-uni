import 'package:flutter/material.dart';

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

  /// Build a header for the drawer.
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
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build navigation list.
  List<ListTile> _buildNavigationList(BuildContext context) {
    return [
      ListTile(
        title: Text('Home page'),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
      ),
      ListTile(
        title: Text('Favorites'),
        leading: Icon(Icons.favorite),
        onTap: () => Navigator.of(context).pushReplacementNamed('/favorites'),
      )
    ];
  }
}
