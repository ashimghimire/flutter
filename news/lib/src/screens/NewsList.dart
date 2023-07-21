import 'package:flutter/material.dart';
import 'package:news/src/data/StoriesBloc.dart';
import 'package:news/src/provider/StoriesProvider.dart';
import 'package:news/src/resources/Repository.dart';
import 'package:news/src/widgets/news_list_tile.dart';

import '../widgets/refresh.dart';
class NewsList extends StatelessWidget {
  const NewsList({super.key});
  @override
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Top Hacker News'),backgroundColor:Colors.redAccent,), body: buildList(bloc));
  }

  Widget buildList(StoriesBloc? bloc)  {
      return Refresh(FutureBuilder(
          future:getFuture(),
          builder: (context, snapshot) {
            var data = snapshot.hasData ? snapshot.data as List<int>:[];
            return Container(
              child: ListView.builder(
                  itemCount:data.length,
                  itemBuilder: (context,int index){
                    bloc?.fetchItems(data[index]);
                    return NewsListTile(itemId: data[index]);
                  }),
            );
          }
      ));
      }


  getFuture() async {
  var repository=Repository();
  return await repository.fetchTopIds();
  }

}
