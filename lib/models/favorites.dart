import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_fit/entities/domain/item-group.dart';

class FavoritesModel extends ChangeNotifier {
  List<ItemGroup> _favorites;

  /// Favorites.
  List<ItemGroup> get favorites => _favorites;

  /// Http client.
  Client httpClient = Client();

  FavoritesModel({this.httpClient}) {
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

const DUMMY_ITEM_GROUPS = <ItemGroup>[];
