import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit/providers/item-groups.provider.dart';

import 'login-page.dart';
import 'models/domain/item-group.dart';

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
      drawer: _Drawer(context),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      builder: (context, snapshot) {
        return GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(8),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
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
    final _cardRadius = BorderRadius.all(Radius.circular(8));
    var _cardChild = Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: _cardRadius,
      ),
    );

    if (item != null) {
      _cardChild = Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: _cardRadius,
          image: DecorationImage(
            image: NetworkImage(item.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Card(
      child: _cardChild,
    );
  }
}

class _Drawer extends StatelessWidget {
  _Drawer(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
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
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Icon(Icons.account_circle),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
