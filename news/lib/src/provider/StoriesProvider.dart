import 'package:flutter/material.dart';
import '../data/StoriesBloc.dart';
import '../model/ItemModel.dart';
import '../resources/Repository.dart';
export 'StoriesProvider.dart';

class StoriesProvider extends InheritedWidget {
  final bloc = StoriesBloc();

  StoriesProvider({required Key key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static StoriesBloc? of(BuildContext context) {

    try {
      if (context.dependOnInheritedWidgetOfExactType<StoriesProvider>() !=
          null) {
        throw Exception('NullPointerExceptions');
      } else {
        return (context
            .dependOnInheritedWidgetOfExactType<StoriesProvider>()!
            .bloc);
      }
    } catch (e) {

      return (context
          .dependOnInheritedWidgetOfExactType<StoriesProvider>()
          ?.bloc);
    }
  }
}
