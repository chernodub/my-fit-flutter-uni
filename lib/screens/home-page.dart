import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit/common/splash-container.dart';
import 'package:my_fit/entities/domain/item-group.dart';
import 'package:my_fit/entities/domain/item.dart';
import 'package:my_fit/models/training.dart';
import 'package:my_fit/common/main-drawer.dart';
import 'package:my_fit/screens/browse-item-page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const title = 'Recommendations';

  /// Item group to display
  final ItemGroup itemGroup;

  HomePage({Key key, this.itemGroup}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get _itemGroupPresented {
    return widget.itemGroup != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.title),
      ),
      body: _buildBody(),
      drawer: !_itemGroupPresented ? MyFitMainDrawer(context) : null,
      floatingActionButton: !_itemGroupPresented ? _buildFab(context) : null,
    );
  }

  Widget _buildFab(BuildContext context) {
    final training = Provider.of<TrainingModel>(context);
    return _FabAssessItemGroup(
      onLikeCallback: () => training.assessItemGroup(2),
      onDislikeCallback: () => training.assessItemGroup(0),
    );
  }

  Widget _buildBody() {
    return _itemGroupPresented
        ? _buildList(_buildItemsListFromItemGroup(widget.itemGroup))
        : Consumer<TrainingModel>(
            builder: (_, model, __) => _buildList(
              model.itemGroupToAssess != null
                  ? _buildItemsListFromItemGroup(model.itemGroupToAssess)
                  : _buildItemsListSkeleton(),
            ),
          );
  }

  ListView _buildList(List<Widget> children) {
    return ListView(children: children);
  }

  List<Widget> _buildItemsListFromItemGroup(ItemGroup itemGroup) {
    final onItemTapCallback = (Item item) => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => BrowseItemPage(item)),
        );

    /// TODO (Viktor C): Improve the logic, now it is only for 3 items
    return [
      Container(
        height: 400,
        child: _ItemCard(
          context: context,
          item: itemGroup.items[0],
          onItemTapCallback: onItemTapCallback,
        ),
      ),
      GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          children: itemGroup.items
              .sublist(1, itemGroup.items.length)
              .map((item) => _ItemCard(
                    context: context,
                    item: item,
                    onItemTapCallback: onItemTapCallback,
                  ))
              .toList())
    ];
    // return itemGroup.items
    //     .map((item) => _ItemCard(
    //           context: context,
    //           item: item,
    //           onItemTapCallback: onItemTapCallback,
    //         ))
    //     .toList();
  }

  List<Widget> _buildItemsListSkeleton() {
    const maxSkeletonItems = 4;
    final itemsNum = Random().nextInt(maxSkeletonItems) + 2;
    return List.filled(itemsNum, null)
        .map((item) => _ItemCard(context: context, item: item))
        .toList();
  }
}

class _FabAssessItemGroup extends StatelessWidget {
  final void Function() onDislikeCallback;
  final void Function() onLikeCallback;

  _FabAssessItemGroup({this.onDislikeCallback, this.onLikeCallback});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingModel>(
        builder: (BuildContext context, TrainingModel value, Widget child) {
      final theme = Theme.of(context);
      final isFabDisabled = value.itemGroupToAssess == null;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'Dislike',
            tooltip: 'Dislike outfit',
            backgroundColor: isFabDisabled ? theme.disabledColor : null,
            onPressed: isFabDisabled ? null : onDislikeCallback,
            child: Icon(Icons.thumb_down),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            heroTag: 'Like',
            tooltip: 'Like outfit',
            backgroundColor: isFabDisabled ? theme.disabledColor : null,
            onPressed: isFabDisabled ? null : onLikeCallback,
            child: Icon(Icons.thumb_up),
          ),
        ],
      );
    });
  }
}

class _FabNextItemGroup extends StatelessWidget {
  /// On fab click callback.
  final Function() onClickCallback;

  _FabNextItemGroup({this.onClickCallback});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingModel>(
      builder: (BuildContext context, TrainingModel value, Widget child) {
        final theme = Theme.of(context);
        final isFabDisabled = value.itemGroupToAssess == null;
        return FloatingActionButton(
          backgroundColor: isFabDisabled ? theme.disabledColor : null,
          heroTag: 'Next',
          onPressed: isFabDisabled ? null : this.onClickCallback,
          tooltip: 'Get next reccomendation',
          child: Icon(Icons.navigate_next),
        );
      },
    );
  }
}

class _ItemCard extends StatelessWidget {
  /// On item card click callback
  final Function(Item) onItemTapCallback;

  /// Item.
  final Item item;

  /// Context.
  final BuildContext context;

  _ItemCard({
    @required this.item,
    @required this.context,
    this.onItemTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    const cardRadius = 8.0;

    return Card(
      child: item != null ? _buildCardContent() : _buildCardContentSkeleton(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      clipBehavior: Clip.hardEdge,
    );
  }

  Widget _buildCardContent() {
    return GestureDetector(
      onTap: () => onItemTapCallback(item),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).splashColor,
          image: DecorationImage(
            image: NetworkImage(item.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCardContentSkeleton() => SplashContainer(context: context);
}
