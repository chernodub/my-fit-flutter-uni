import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit/widgets/favorite-group-card.dart';
import 'package:my_fit/widgets/main-drawer.dart';

import 'entities/domain/item-group.dart';
import 'models/training.model.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<List<ItemGroup>> _data;

  @override
  void initState() {
    final provider = TrainingModel();
    _data = provider.getFavoriteItemGroups();
    super.initState();
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
