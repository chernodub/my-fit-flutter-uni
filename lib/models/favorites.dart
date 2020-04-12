import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_fit/entities/domain/item-group.dart';
import 'package:my_fit/models/app-config.dart';

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
  void askForFavoriteGroups() async {
    _favorites = null;

    notifyListeners();

    final response =
        await httpClient.get('${AppConfig.apiUrl}item-groups/favorites');
    _favorites = (jsonDecode(response.body) as List<dynamic>)
        .map(
          (item) => ItemGroup.fromDto(item),
        )
        .toList();

    notifyListeners();
  }
}
