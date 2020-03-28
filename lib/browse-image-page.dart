import 'package:flutter/material.dart';

class BrowseImagePage extends StatelessWidget {
  final String imageUrl;

  BrowseImagePage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Image(image: NetworkImage(imageUrl)),
      backgroundColor: Colors.black,
    );
  }
}
