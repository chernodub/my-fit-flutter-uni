import 'package:my_fit/models/domain/item-group.dart';

class ItemGroupProvider {
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
}
