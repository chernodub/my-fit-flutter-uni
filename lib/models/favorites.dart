import 'package:flutter/material.dart';
import 'package:my_fit/entities/domain/item-group.dart';
import 'package:my_fit/entities/domain/item.dart';

class FavoritesModel extends ChangeNotifier {
  List<ItemGroup> _favorites;

  List<ItemGroup> get favorites => _favorites;

  FavoritesModel() {
    askForFavoriteGroups();
  }

  /// Get favorite groups.
  Future<List<ItemGroup>> askForFavoriteGroups() async {
    _favorites = null;

    notifyListeners();

    /// TODO: change to a request.
    await Future.delayed(Duration(milliseconds: 2000));

    final favorites = Future.value(DUMMY_ITEM_GROUPS);

    saveFavorites(favorites);

    return favorites;
  }

  void saveFavorites(Future<List<ItemGroup>> favoritesData) async {
    _favorites = await favoritesData;
    notifyListeners();
  }
}

const DUMMY_ITEM_GROUPS = [
  ItemGroup([
    Item(
        'https://www.yoox.com/images/items/42/42666373nf_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
    Item(
        'https://www.yoox.com/images/items/41/41926224rc_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
    Item(
        'https://www.yoox.com/images/items/42/42792445wi_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
  ]),
  ItemGroup([
    Item(
        'https://www.yoox.com/images/items/41/41956461vm_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
    Item(
        'https://www.yoox.com/images/items/42/42666373nf_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
    Item(
        'https://www.yoox.com/images/items/12/12312716fq_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
    Item(
        'https://www.yoox.com/images/items/13/13315224ll_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
  ]),
  ItemGroup([
    Item(
        'https://www.yoox.com/images/items/12/12312716fq_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
    Item(
        'https://www.yoox.com/images/items/13/13315224ll_14_f.jpg?width=1571&height=2000&impolicy=crop&gravity=Center'),
  ]),
];
