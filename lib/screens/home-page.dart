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

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.title),
      ),
      body: _buildBody(),
      drawer: MyFitMainDrawer(context),
      floatingActionButton: _buildFab(context),
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
    return Consumer<TrainingModel>(
      builder: (_, model, __) => _ItemGroupContainer(),
    );
  }

  ListView _buildList(List<Widget> children) {
    return ListView(
      children: children,
      primary: true,
    );
  }

  List<Widget> _buildItemsListFromItemGroup(ItemGroup itemGroup) {
    final onItemTapCallback = (Item item) => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => BrowseItemPage(item)),
        );

    return [
      Container(
        height: 400,
        child: _ItemCard(
          item: itemGroup.items[0],
          onItemTapCallback: onItemTapCallback,
        ),
      ),
      GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          primary: false,
          children: itemGroup.items
              .sublist(1, itemGroup.items.length)
              .map((item) => _ItemCard(
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
        .map((item) => _ItemCard(item: item))
        .toList();
  }
}

/// TODO remove fabs at all
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

class _ItemGroupContainer extends StatefulWidget {
  final bool shouldWrap;
  final ItemGroup itemGroup;
  _ItemGroupContainer({
    this.shouldWrap = false,
    this.itemGroup,
  });

  @override
  State<StatefulWidget> createState() => _ItemGroupContainerState();
}

class _ItemGroupContainerState extends State<_ItemGroupContainer> {
  final defaultItemSize = 150.0;
  final primaryItemHeight = 400.0;
  final animationDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final items =
        widget.itemGroup != null ? widget.itemGroup.items : [null, null, null];
    return AnimatedContainer(
      child: ListView(
        primary: true,
        children: [
          AnimatedContainer(
            duration: animationDuration,
            height: widget.shouldWrap ? defaultItemSize : primaryItemHeight,
            width: defaultItemSize,
            child: _ItemCard(
              item: items[0],
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            primary: false,
            children: items
                .sublist(1)
                .map(
                  (i) => AnimatedContainer(
                    child: _ItemCard(
                      item: i,
                    ),
                    duration: animationDuration,
                    width: defaultItemSize,
                  ),
                )
                .toList(),
          )
        ],
      ),
      transform: widget.shouldWrap ? (Matrix4.identity()..scale(0.5)) : null,
      duration: animationDuration,
    );
  }
}

class _ItemCard extends StatelessWidget {
  /// On item card click callback
  final Function(Item) onItemTapCallback;

  /// Item.
  final Item item;

  _ItemCard({
    @required this.item,
    this.onItemTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    const cardRadius = 8.0;

    return Card(
      child: item != null
          ? _buildCardContent(context)
          : _buildCardContentSkeleton(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
      ),
      clipBehavior: Clip.hardEdge,
    );
  }

  Widget _buildCardContent(BuildContext context) {
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

  Widget _buildCardContentSkeleton() => SplashContainer();
}
