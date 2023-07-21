import 'package:flutter/material.dart';
import 'package:news/src/provider/StoriesProvider.dart';
import 'package:news/src/widgets/loading_container.dart';
import 'dart:async';
import '../model/ItemModel.dart';

class NewsListTile extends StatelessWidget{
  final int itemId;

  NewsListTile({required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc =StoriesProvider.of(context);
    return StreamBuilder(stream:bloc?.items,
    builder: (context, AsyncSnapshot<Map<int,Future<ItemModel?>>> snapshot ){
      if(!snapshot.hasData) {
        return LoadingContainer();
      }

      snapshot?.data![itemId]?.then((value) => print(value?.title));
      return FutureBuilder(
          future:snapshot?.data![itemId],
          builder: (context, snapshotData){
           if(!snapshotData.hasData) return LoadingContainer();
          var data=snapshotData?.data?.title;
          return BuildTile(snapshotData.data as ItemModel,context);
      });

    });




  }

  Widget BuildTile(ItemModel item, BuildContext context){
    return Column(children: [
      ListTile(title:Text(item.title),
      onTap: (){
        Navigator.pushNamed(context,"/${item?.id}");
      },
      leading: Image(image: NetworkImage("https://res.cloudinary.com/dffbsiy8t/image/upload/v1689926711/fire-letter-n-your-design-50682059_x9s7xo.jpg") ,),
      subtitle: Text("${item.score} points"),
      trailing: Column(children: [Icon(Icons.comment),Text("${item.descendants}")],)),
      Divider(height: 10.0,)
    ]);
  }

}