
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/src/data/CommentBloc.dart';
import 'package:news/src/provider/CommentsProvider.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../widgets/Comment.dart';
import '../model/ItemModel.dart';

class NewsDetail extends StatelessWidget {
  late int? itemid;
  NewsDetail(this.itemid);

  @override
  Widget build(BuildContext context){
    CommentsBloc? bloc = CommentsProvider.of(context);
    return Scaffold(appBar:
        AppBar(title:
        Text("Detail")),
        body: buildBody(bloc));
  }

  Widget buildBody(CommentsBloc? bloc){
    return StreamBuilder(stream:bloc?.itemWithComments,builder: (context, AsyncSnapshot<Map<int,Future<ItemModel?>>> snapshot){
      if(!snapshot.hasData) return LoadingContainer();
      final itemFuture = snapshot.data![itemid];
      return FutureBuilder(future:itemFuture,
          builder: (context,itemSnapshot){
            if(!itemSnapshot.hasData) return LoadingContainer();
            return buildList(itemSnapshot?.data,snapshot.data!);
    });
  });
}

  Widget buildList(ItemModel? item, Map<int, Future<ItemModel?>> itemMap) {
    final children=<Widget>[];
    children.add(Container(margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child:Text("${item?.title}",
        textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
    ));

    final commentList= item?.kids.map((e) => Comment(itemMap, e,1) ).toList();
    children.addAll(commentList as Iterable<Widget>);
    return ListView(children: children);
  }


}