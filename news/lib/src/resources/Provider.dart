import '../model/ItemModel.dart';

abstract class Provider {
  fetchTopIds();
  fetchItem(int id);
  addItem(ItemModel item);
}
