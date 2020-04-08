import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit/browse-image-page.dart';
import 'package:my_fit/entities/domain/item-group.dart';
import 'package:my_fit/entities/domain/item.dart';
import 'package:my_fit/models/training.dart';
import 'package:my_fit/common/main-drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const title = 'My Fit';
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
    return _FabNextItemGroup(
      onClickCallback: () => training.requestNewItemGroupToAssess(),
    );
  }

  Widget _buildBody() {
    return Consumer<TrainingModel>(
      builder: (_, model, __) => _buildGrid(
        model.itemGroupToAssess != null
            ? _buildItemsListFromItemGroup(model.itemGroupToAssess)
            : _buildItemsListSkeleton(),
      ),
    );
  }

  GridView _buildGrid(List<Widget> children) {
    return GridView.count(
      crossAxisCount: 2,
      children: children,
    );
  }

  List<Widget> _buildItemsListFromItemGroup(ItemGroup itemGroup) {
    return itemGroup.items.map((item) => _buildItemCard(item)).toList();
  }

  List<Widget> _buildItemsListSkeleton() {
    return [null, null, null].map((item) => _buildItemCard(item)).toList();
  }

  Widget _buildItemCard(Item item) {
    final cardRadius = 8.0;
    final cardBackgroundColor = Theme.of(context).splashColor;
    final onTapAction = _getOnItemTapAction(item);

    /// TODO refactor this logic
    Widget _cardChild = Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
      ),
    );

    if (item != null) {
      _cardChild = Container(
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          image: DecorationImage(
            image: NetworkImage(item.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTapAction,
      child: Card(
        child: _cardChild,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        clipBehavior: Clip.hardEdge,
      ),
    );
  }

  Function() _getOnItemTapAction(Item item) {
    if (item == null) {
      return null;
    }

    return () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BrowseImagePage(item.imageUrl),
          ),
        );
  }
}

class _FabAssessItemGroup extends StatelessWidget {
  final void Function() dislikeCallback;
  final void Function() likeCallback;

  _FabAssessItemGroup({this.dislikeCallback, this.likeCallback});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'Dislike',
          onPressed: () => dislikeCallback != null ? dislikeCallback() : null,
          child: Icon(Icons.thumb_down),
        ),
        SizedBox(width: 12),
        FloatingActionButton(
          heroTag: 'Like',
          onPressed: () => dislikeCallback != null ? likeCallback() : null,
          child: Icon(Icons.thumb_up),
        ),
      ],
    );
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
          child: Icon(Icons.navigate_next),
        );
      },
    );
  }
}
