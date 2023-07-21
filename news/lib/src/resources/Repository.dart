import 'package:news/src/db/NewsApiDbProvider.dart';
import 'package:news/src/model/ItemModel.dart';
import 'package:news/src/resources/NewsApiProvider.dart';

class Repository {
  List<Source> sources = <Source>[NewsApiProvider(), NewsDbProvider()];
  List<Cache> caches = <Cache>[NewsDbProvider()];

  Future<List<int>> fetchTopIds() async {
    return await sources[0].fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id)  async {
    late ItemModel item;
    Source source;
    for (source in sources) {
       item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
      for (var cache in caches) {
        if(caches!=(source as Cache)) {
          cache.addItem(item);
        }
      }
    }
    return item;
  }

 clearCache() async {
    for( var cache in caches){
       await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  void addItem(ItemModel item);
  Future<int> clear();
}
