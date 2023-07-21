import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../model/ItemModel.dart';
import '../resources/Repository.dart';

class CommentsBloc extends Object {
  final _news = PublishSubject<ItemModel>();
  final _repository = Repository();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _commentsFetcher = PublishSubject<int>();

  Stream<Map<int, Future<ItemModel?>>> get itemWithComments => _commentsOutput.stream;
  Stream<Map<int, Future<ItemModel?>>> get items => _commentsOutput.stream;
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput.sink);
  }

  StreamTransformer<int, Map<int, Future<ItemModel?>>> _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel?>>>(
          (accumulated, id, index) {
        accumulated[id] = _repository.fetchItem(id);
        print(index);
        accumulated[id]?.then((ItemModel? value) {
          value?.kids?.forEach((element) async  { return await fetchItemWithComments(element);});
        });
        return accumulated;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  clearCache() async{
    return await _repository.clearCache();
  }

  dispose() {
    _commentsOutput.close();
    _commentsFetcher.close();
  }
}