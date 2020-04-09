import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_fit/common/main-drawer.dart';
import 'package:my_fit/common/splash-container.dart';
import 'package:my_fit/entities/domain/item-group.dart';
import 'package:my_fit/entities/domain/item.dart';
import 'package:my_fit/models/favorites.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite pieces'),
      ),
      drawer: MyFitMainDrawer(context),
      body: Consumer<FavoritesModel>(
        builder: (BuildContext context, FavoritesModel model, _) =>
            _buildFavouriteGroupsList(model.favorites),
      ),
    );
  }

  /// Build list of a cards displaying favorite groups.
  ListView _buildFavouriteGroupsList(List<ItemGroup> favorites) {
    // Is data loading.
    if (favorites == null) {
      return _buildSkeletonList();
    }

    // Is there no favorites.
    if (favorites.length == 0) {
      return _buildEmptyList();
    }

    return ListView(
      children: favorites
          .map((itemGroup) => _FavoriteGroupCard(context, itemGroup))
          .toList(),
    );
  }

  ListView _buildSkeletonList() {
    const maxSkeletonItems = 3;
    final itemsNum = Random().nextInt(maxSkeletonItems) + 1;
    return ListView(
      children: List.filled(itemsNum, null)
          .map((itemGroup) => _FavoriteGroupCard(context, itemGroup))
          .toList(),
    );
  }

  ListView _buildEmptyList() {}
}

class _FavoriteGroupCard extends StatelessWidget {
  /// Item group to preview.
  final ItemGroup itemGroup;

  final BuildContext context;

  _FavoriteGroupCard(this.context, this.itemGroup);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _FavoriteGroupCardPreview(context, itemGroup),
          ],
        ),
      ),
    );
  }
}

class _FavoriteGroupCardPreview extends StatelessWidget {
  /// Count of images on a tile.
  final int _tilePreviewItemsLen = 3;

  /// Item group to preview.
  final ItemGroup itemGroup;

  final BuildContext context;

  _FavoriteGroupCardPreview(this.context, this.itemGroup);

  @override
  Widget build(BuildContext context) {
    return itemGroup != null
        ? _buildCardPreview(itemGroup.items)
        : _buildCardPreviewSkeleton();
  }

  /// Build the preview images for the tile.
  Widget _buildCardPreview(List<Item> items) {
    final previewItems = _buildReducedPreviewList(items);

    return Row(
      children: _insertDividersToList(
          previewItems.map((item) => Expanded(child: item)).toList(), 8),
    );
  }

  Widget _buildCardPreviewSkeleton() {
    const maxSkeletonItems = 2;
    final itemsNum = Random().nextInt(maxSkeletonItems) + 2;
    final previewItems = _buildPreviewList(List.filled(itemsNum, null));
    return Row(
      children: _insertDividersToList(
          previewItems.map((item) => Expanded(child: item)).toList(), 8),
    );
  }

  /// Insert dividers between the images.
  List<Widget> _insertDividersToList(List<Widget> list, double width) {
    final List<Widget> producedList = [];

    for (int i = 0; i < list.length; i++) {
      producedList.add(list[i]);
      if (i != list.length - 1) {
        producedList.add(SizedBox(width: width));
      }
    }

    return producedList;
  }

  /// Reduce number of preview images to give a user understanding how many items there were.
  List<Widget> _buildReducedPreviewList(List<Item> items) {
    /// Check if
    final announceCount = items.length - _tilePreviewItemsLen;
    if (announceCount > 0) {
      return _buildPreviewList(
        items.sublist(0, _tilePreviewItemsLen),
        announceCount: announceCount + 1, // + 1 to count the announce too.
      );
    }
    return _buildPreviewList(items);
  }

  /// Build vertical list of items for the preview.
  List<Widget> _buildPreviewList(
    List<Item> items, {
    int announceCount,
  }) {
    final lastItem = items[items.length - 1];
    return items
        .sublist(0, items.length - 1)
        .map((item) => _FavoriteGroupCardPreviewListItem(
              context: context,
              item: item,
            ))
        .toList()
          ..add(_FavoriteGroupCardPreviewListItem(
            context: context,
            item: lastItem,
            announceCount: announceCount,
          ));
  }
}

class _FavoriteGroupCardPreviewListItem extends StatelessWidget {
  /// Item to render.
  final Item item;

  /// Announce count.
  final int announceCount;

  /// Context.
  final BuildContext context;

  _FavoriteGroupCardPreviewListItem({
    @required this.item,
    @required this.context,
    this.announceCount,
  });

  @override
  Widget build(BuildContext context) {
    final previewItem = announceCount != null
        ? _buildAnnounceWidget(announceCount, item.imageUrl)
        : _buildPreviewItem(item);
    return Container(
      child: previewItem,
      height: 135,
    );
  }

  /// Build preview item.
  Widget _buildPreviewItem(Item item) {
    return item == null
        ? _buildPreviewItemSkeleton()
        : Container(
            color: Theme.of(context).splashColor,
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
            ),
          );
  }

  /// Build preview item skeleton.
  Widget _buildPreviewItemSkeleton() {
    return SplashContainer(context: context);
  }

  /// Build widget for announcing more items. Displays the number of additional items.
  Widget _buildAnnounceWidget(int announceCount, String announceBackgroundUrl) {
    final decoration = announceBackgroundUrl != null
        ? _buildDecorationForAnnounceItem(announceBackgroundUrl)
        : null;

    return Stack(
      children: <Widget>[
        Opacity(
          child: Container(
            decoration: decoration,
          ),
          opacity: 0.6,
        ),
        Center(
            child: Text(
          '+' + announceCount.toString(),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        )),
      ],
    );
  }

  /// Build preview image for a tile.
  BoxDecoration _buildDecorationForAnnounceItem(String imageUrl) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      ),
      color: Theme.of(context).splashColor,
    );
  }
}
