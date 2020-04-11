import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_fit/entities/domain/item-group.dart';
import 'package:my_fit/models/app-config.dart';
import 'package:http/http.dart';

/// Training model.
class TrainingModel extends ChangeNotifier {
  /// Item group to assess.
  ItemGroup _itemGroupToAssess;

  /// Item group to assess.
  ItemGroup get itemGroupToAssess => _itemGroupToAssess;

  /// Http client.
  Client httpClient = Client();

  TrainingModel({this.httpClient}) {
    requestNewItemGroupToAssess();
  }

  /// Get item group for the user to assess.
  void requestNewItemGroupToAssess() async {
    _itemGroupToAssess = null;
    notifyListeners();

    final response =
        await httpClient.get('${AppConfig.apiUrl}item-groups/random');

    _itemGroupToAssess = ItemGroup.fromDto(json.decode(response.body));
    notifyListeners();
  }
}
