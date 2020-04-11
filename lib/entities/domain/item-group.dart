import 'package:flutter/material.dart';

import 'item.dart';

class ItemGroup {
  /// Id of an item group.
  final int id;

  /// List of items.
  final List<Item> items;

  const ItemGroup({@required this.id, this.items = const []});

  factory ItemGroup.fromDto(Map<String, dynamic> json) {
    return ItemGroup(
      id: json['id'],
      items: (json['items'] as List<dynamic>)
          .map(
            (itemJson) => Item.fromDto(itemJson),
          )
          .toList(),
    );
  }
}
