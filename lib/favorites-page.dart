import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit/models/domain/item-group.dart';
import 'package:my_fit/providers/item-groups.provider.dart';
import 'package:my_fit/widgets/favorite-group-card.dart';
import 'package:my_fit/widgets/main-drawer.dart';

import 'models/domain/item.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<List<ItemGroup>> _data;

  @override
  Future<void> initState() {
    final provider = ItemGroupProvider();
    _data = provider.getFavoriteItemGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite pieces'),
      ),
      drawer: MyFitMainDrawer(context),
      body: FutureBuilder(
        builder: (context, snapshot) =>
            _buildFavouriteGroupsList(snapshot.data),
        future: _data,
        initialData: null,
      ),
    );
  }

  /// Build list of a cards displaying favorite groups.
  ListView _buildFavouriteGroupsList(List<ItemGroup> data) {
    return ListView(
        children: (data != null ? data : [null, null, null])
            .map(
              (itemGroup) => FavoriteGroupCard(itemGroup),
            )
            .toList());
  }
}
