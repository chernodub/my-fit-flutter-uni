import 'package:flutter/material.dart';
import 'package:my_fit/models/user.dart';
import 'package:provider/provider.dart';

class MyFitMainDrawer extends StatelessWidget {
  MyFitMainDrawer(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) => Drawer(
        child: Column(
          children: <Widget>[
            _MainDrawerHeader(
              context: context,
              user: value.user,
            ),
            ..._buildNavigationList(context),
          ],
        ),
      ),
    );
  }

  /// Build navigation list.
  List<ListTile> _buildNavigationList(BuildContext context) {
    return [
      ListTile(
        title: Text('Recommendations'),
        leading: Icon(Icons.all_inclusive),
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

/// Drawer header.
class _MainDrawerHeader extends StatelessWidget {
  /// User.
  final User user;
  final BuildContext context;

  _MainDrawerHeader({
    @required this.context,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Close the menu',
                ),
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/login'),
                  tooltip: 'Log out',
                ),
              ],
            ),
            _ProfileAvatar(user),
          ],
        ),
      ),
    );
  }
}

/// Profile avatar widget. Provides information about a [user].
class _ProfileAvatar extends StatelessWidget {
  /// User.
  final User user;
  _ProfileAvatar(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.person,
            color: Theme.of(context).iconTheme.color,
          ),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          user != null ? user.email : 'Not logged',
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
