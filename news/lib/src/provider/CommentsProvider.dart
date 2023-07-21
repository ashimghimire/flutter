import 'package:flutter/material.dart';
import '../data/CommentBloc.dart';
import '../data/StoriesBloc.dart';
import '../model/ItemModel.dart';
import '../resources/Repository.dart';
export 'StoriesProvider.dart';

class CommentsProvider extends InheritedWidget {
  final bloc = CommentsBloc();

  CommentsProvider({required Key key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CommentsBloc? of(BuildContext context) {

    try {
      if (context.dependOnInheritedWidgetOfExactType<CommentsProvider>() !=
          null) {
        throw Exception('NullPointerExceptions');
      } else {
        return (context
            .dependOnInheritedWidgetOfExactType<CommentsProvider>()!
            .bloc);
      }
    } catch (e) {

      return (context
          .dependOnInheritedWidgetOfExactType<CommentsProvider>()
          ?.bloc);
    }
  }
}
