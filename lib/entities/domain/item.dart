import 'package:flutter/material.dart';

class Item {
  /// Id.
  final int id;

  /// Image url.
  final String imageUrl;

  const Item({
    @required this.id,
    this.imageUrl,
  });

  factory Item.fromDto(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      imageUrl: json['image'],
    );
  }
}
