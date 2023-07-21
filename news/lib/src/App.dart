import 'package:flutter/material.dart';
import 'package:news/src/data/CommentBloc.dart';
import 'package:news/src/provider/CommentsProvider.dart';
import 'package:news/src/provider/StoriesProvider.dart';
import 'package:news/src/widgets/NewsDetail.dart';
import 'screens/NewsList.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(context) {
    return
      CommentsProvider(key:GlobalKey(debugLabel: 'comments'), child: StoriesProvider(
          key: GlobalKey(debugLabel: 'stories'),
          child:  MaterialApp(
              title: 'Top Hacker News',
              onGenerateRoute: routes
          )));
  }

  Route routes(RouteSettings settings){
    if(settings.name=='/'){
      return MaterialPageRoute(builder: (context){
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context){
        final CommentsBloc? commentsBloc=CommentsProvider.of(context);
        final  itemId= int.parse("${settings.name?.replaceFirst("/", "")}");
        commentsBloc?.fetchItemWithComments(itemId);
        return NewsDetail(itemId);
      });
    }

  }
}
