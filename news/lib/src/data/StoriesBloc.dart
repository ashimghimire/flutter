import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../model/ItemModel.dart';
import '../resources/Repository.dart';

class StoriesBloc extends Object {
  final _topIds = PublishSubject<List<int>>();
  final _repository = Repository();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _itemFetcher = PublishSubject<int>();

  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<ItemModel?>>> get items => _itemsOutput.stream;
  Function(int) get fetchItems => _itemFetcher.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  StoriesBloc() {
    _itemFetcher.stream
        .transform(_itemsTransformer())
        .pipe(_itemsOutput.sink);
  }

  StreamTransformer<int, Map<int, Future<ItemModel?>>> _itemsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel?>>>(
          (accumulated, id, index) {
        accumulated[id] = _repository.fetchItem(id);
        accumulated[id]?.then((value) => print(value?.title));
        return accumulated;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  clearCache() async{
    return await _repository.clearCache();
  }

  dispose() {
    _topIds.close();
    _itemFetcher.close();
    _itemsOutput.close();
  }
}