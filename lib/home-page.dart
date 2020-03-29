import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit/providers/item-groups.provider.dart';

import 'browse-image-page.dart';
import 'models/domain/item-group.dart';
import 'models/domain/item.dart';
import 'widgets/main-drawer.dart';

class HomePage extends StatefulWidget {
  static const title = 'My Fit';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ItemGroup> _data;

  @override
  Future<void> initState() {
    final provider = ItemGroupProvider();
    _data = provider.getItemGroupToAssess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.title),
      ),
      body: _buildBody(),
      drawer: MyFitMainDrawer(context),
      floatingActionButton: _Fab(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      builder: (context, snapshot) {
        return GridView.count(
          crossAxisCount: 2,
          children: snapshot.data != null
              ? _buildItemsListFromItemGroup(snapshot.data)
              : _buildItemsListSkeleton(),
        );
      },
      future: _data,
      initialData: null,
    );
  }

  List<Widget> _buildItemsListFromItemGroup(ItemGroup itemGroup) {
    return itemGroup.items.map((item) => _buildItem(item)).toList();
  }

  List<Widget> _buildItemsListSkeleton() {
    return [null, null, null].map((item) => _buildItem(item)).toList();
  }

  Widget _buildItem(Item item) {
    double cardRadius = 8.0;
    Color cardColor = Theme.of(context).primaryColorLight;
    Widget _cardChild = Container(
      decoration: BoxDecoration(
        color: cardColor,
      ),
    );

    if (item != null) {
      _cardChild = Container(
        decoration: BoxDecoration(
          color: cardColor,
          image: DecorationImage(
            image: NetworkImage(item.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BrowseImagePage(item.imageUrl),
        ),
      ),
      child: Card(
        child: _cardChild,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        clipBehavior: Clip.hardEdge,
      ),
    );
  }
}

class _Fab extends StatelessWidget {
  final void Function() dislikeCallback;
  final void Function() likeCallback;

  _Fab({this.dislikeCallback, this.likeCallback});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'Dislike',
          onPressed: () => null,
          child: Icon(Icons.thumb_down),
        ),
        SizedBox(width: 12),
        FloatingActionButton(
          heroTag: 'Like',
          onPressed: () => null,
          child: Icon(Icons.thumb_up),
        ),
      ],
    );
  }
}
