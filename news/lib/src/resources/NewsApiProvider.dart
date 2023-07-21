import 'dart:convert';
import 'package:http/http.dart' show Client;

import 'package:news/src/resources/Repository.dart';
import '../model/ItemModel.dart';

class NewsApiProvider extends Source {
  Client client = Client();
  @override
  Future<List<int>> fetchTopIds() async {
    var resolve = Uri().resolve("https://hacker-news.firebaseio.com/v0/topstories.json");
    final response = await client
        .get(resolve);
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
   try {
     var resolve = Uri().resolve(
         "https://hacker-news.firebaseio.com/v0/item/$id.json");

     final response = await client
         .get(resolve);
     final item = json.decode(response.body);

     return ItemModel.fromJson(item);
   }on Exception{
    return ItemModel(12, false, 'news', 'asim', 32434, 'text', false, 23, [], 'sdsd', 0, 'Plane is flying', 43);
   }
  }
}
