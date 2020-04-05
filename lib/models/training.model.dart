import 'package:flutter/material.dart';
import 'package:my_fit/entities/domain/item-group.dart';
import 'package:my_fit/entities/domain/item.dart';

/// Training model.
class TrainingModel extends ChangeNotifier {
  /// Get item group for the user to assess.
  Future<ItemGroup> getItemGroupToAssess() async {
    return Future.delayed(new Duration(seconds: 2)).then(
      (_) => new ItemGroup([
        new Item(
            'https://www.yoox.com/images/items/38/38904665mg_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
        new Item(
            'https://www.yoox.com/images/items/13/13449138md_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
      ]),
    );
  }

  /// Get favorite groups.
  Future<List<ItemGroup>> getFavoriteItemGroups() async {
    return getItemGroupToAssess().then((itemGroup) => [
          itemGroup,
          itemGroup,
          new ItemGroup([
            new Item(
                'https://www.yoox.com/images/items/38/38904665mg_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
            new Item(
                'https://www.yoox.com/images/items/38/38904665mg_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
            new Item(
                'https://www.yoox.com/images/items/38/38904665mg_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
            new Item(
                'https://www.yoox.com/images/items/13/13449138md_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
          ])
        ]);
  }
}
