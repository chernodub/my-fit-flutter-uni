import 'dart:math';

import 'package:flutter/material.dart';

class Item {
  /// Id.
  final int id;

  /// Image url.
  final String imageUrl;

  /// Item url.
  final String url;

  /// Item title.
  final String itemTitle;

  /// Item descripton.
  final String itemDescription;

  /// Item price.
  final double itemPrice;

  /// Is item on sale.
  final bool isOnSale;

  const Item({
    @required this.id,
    this.itemTitle,
    this.itemDescription,
    this.itemPrice,
    this.imageUrl,
    this.url,
    this.isOnSale,
  });

  factory Item.fromDto(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      imageUrl: json['image'],
      itemPrice: Random.secure().nextDouble() * 100,
      itemTitle: 'Cool Item to Wear',
      itemDescription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      url: 'https://en.wikipedia.org/wiki/Special:Random',
      isOnSale: Random().nextBool(),
    );
  }
}
