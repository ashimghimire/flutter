import 'package:flutter/material.dart';
import 'package:news/src/provider/StoriesProvider.dart';
import '../data/StoriesBloc.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  Refresh(this.child);

  @override
  Widget build(context){
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(child: child, onRefresh: () async {
      await bloc?.clearCache();
     await bloc?.fetchTopIds();
    });
  }


}