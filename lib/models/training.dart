import 'package:flutter/material.dart';
import 'package:my_fit/entities/domain/item-group.dart';
import 'package:my_fit/entities/domain/item.dart';

/// Training model.
class TrainingModel extends ChangeNotifier {
  /// Item group to assess.
  ItemGroup _itemGroupToAssess;

  /// Item group to assess.
  ItemGroup get itemGroupToAssess => _itemGroupToAssess;

  TrainingModel() {
    requestNewItemGroupToAssess();
  }

  /// Get item group for the user to assess.
  void requestNewItemGroupToAssess() async {
    _itemGroupToAssess = null;

    notifyListeners();

    await Future.delayed(new Duration(seconds: 2));

    _itemGroupToAssess = ItemGroup([
      new Item(
          'https://www.yoox.com/images/items/38/38904665mg_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
      new Item(
          'https://www.yoox.com/images/items/13/13449138md_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
    ]);

    notifyListeners();
  }
}
