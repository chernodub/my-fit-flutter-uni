import 'package:flutter/material.dart';
import 'package:my_fit/models/domain/item-group.dart';
import 'package:my_fit/models/domain/item.dart';

class FavoriteGroupCard extends StatelessWidget {
  /// Count of images on a tile.
  static const _tilePreviewItemsLen = 3;

  /// Item group to preview.
  final ItemGroup itemGroup;

  FavoriteGroupCard(this.itemGroup);

  /// Build preview image for a tile.
  BoxDecoration _buildDecorationForAnnounceItem(String imageUrl) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.grey, BlendMode.hardLight),
      ),
    );
  }

  /// Build widget for announcing more items. Displays the number of additional items.
  Widget _buildAnnounceWidget(int announceCount, String announceBackgroundUrl) {
    final decoration = announceBackgroundUrl != null
        ? _buildDecorationForAnnounceItem(announceBackgroundUrl)
        : null;

    return Container(
      decoration: decoration,
      child: Center(
          child: Text(
        '+' + announceCount.toString(),
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }

  /// Build a container for the image preview.
  Expanded _buildPreviewItemContainer(Widget content) {
    return Expanded(
      child: Container(
        child: content,
        height: 135,
      ),
    );
  }

  /// Build vertical list of items for the preview.
  List<Widget> _buildVerticalListForItems(
    List<Item> items, {
    int announceCount,
    String announceBackgroundUrl,
  }) {
    final announceWidget = announceCount != null
        ? _buildAnnounceWidget(announceCount, announceBackgroundUrl)
        : null;

    final builtPreview = items.map((item) {
      return _buildPreviewItemContainer(Image.network(
        item.imageUrl,
        fit: BoxFit.cover,
      ));
    }).toList();

    if (announceWidget != null) {
      return builtPreview..add(_buildPreviewItemContainer(announceWidget));
    }

    return builtPreview;
  }

  /// Reduce number of preview images to give a user understanding how many items there were.
  List<Widget> _reduceTilePreview(List<Item> items) {
    final announceCount = items.length - _tilePreviewItemsLen;
    if (announceCount > 0) {
      return _buildVerticalListForItems(
        items.sublist(0, _tilePreviewItemsLen - 1),
        announceCount: announceCount + 1, // + 1 to count the announce too.
        announceBackgroundUrl: items[_tilePreviewItemsLen].imageUrl,
      );
    }
    return _buildVerticalListForItems(items);
  }

  /// Insert dividers between the images.
  List<Widget> _insertDividers(List<Widget> list, double width) {
    final List<Widget> producedList = [];

    for (int i = 0; i < list.length; i++) {
      producedList.add(list[i]);
      if (i != list.length - 1) {
        producedList.add(SizedBox(width: width));
      }
    }

    return producedList;
  }

  /// Build the preview images for the tile.
  Widget _buildTilePreview(ItemGroup group) {
    final itemsLen = group.items.length;
    final shouldReduce = itemsLen > _tilePreviewItemsLen;
    final previewItems = shouldReduce
        ? _reduceTilePreview(group.items)
        : _buildVerticalListForItems(group.items);

    return Row(
      children: _insertDividers(previewItems, 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _buildTilePreview(itemGroup),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {},
                  child: Text('More'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
