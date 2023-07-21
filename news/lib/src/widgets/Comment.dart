import 'package:flutter/material.dart';
import 'package:news/src/data/CommentBloc.dart';
import 'package:news/src/provider/CommentsProvider.dart';
import 'package:news/src/widgets/loading_container.dart';

import '../model/ItemModel.dart';

class Comment extends StatelessWidget {
  Map<int, Future<ItemModel?>> itemsMap;
  int itemId;
  int depth;
  Comment(this.itemsMap,this.itemId, this.depth);
  @override
  Widget build(BuildContext context){

    return FutureBuilder( future:itemsMap[itemId],
        builder: (context, AsyncSnapshot<ItemModel?> snapshot){
      if(!snapshot.hasData) return LoadingContainer();
      final children= <Widget>[
        ListTile(title:buildText(snapshot?.data), contentPadding:EdgeInsets.only(left:depth*16.0), subtitle: Text("${snapshot?.data?.by}"),), Divider()
      ];
      final items=snapshot?.data;
      items?.kids.forEach((element) { children.add(Comment(itemsMap,element,depth+1));});
      return Column(children: children);
    });

  }

  Widget buildText (ItemModel? item){
    final text=item?.text.replaceAll("&#x27", "'").replaceAll("<p>", "\n\n").replaceAll("</p>", "");
    return Text(text!);
  }
}