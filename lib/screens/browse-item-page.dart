import 'package:flutter/material.dart';
import 'package:my_fit/entities/domain/item.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

const SHARE_ITEM_TEXT = 'Check out this item I found!';

class BrowseItemPage extends StatelessWidget {
  /// Image url.
  final Item item;

  BrowseItemPage(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(item.itemTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              final RenderBox box = context.findRenderObject();
              Share.share(
                SHARE_ITEM_TEXT,
                subject: item.url,
                // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_basket),
        onPressed: () async {
          if (await canLaunch(item.url)) {
            await launch(item.url);
          }
        },
      ),
      body: ListView(
        children: <Widget>[
          Image(image: NetworkImage(item.imageUrl)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$ ${item.itemPrice.toString().substring(0, 4)}',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: item.isOnSale ? Colors.red : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.itemDescription,
            ),
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
