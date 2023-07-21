import 'package:flutter_test/flutter_test.dart';
import "package:news/src/resources/NewsApiProvider.dart";
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test(
      'fetchId',
      () => () async {
            // setup
            final newsapi = NewsApiProvider();

            //expectation

            newsapi.client = MockClient((request) async {
              return Response(json.encode([1, 2, 3, 4]), 200);
            });

            final ids = await newsapi.fetchTopIds();

            expect(ids, [1, 2, 3, 4]);
            //
          });

  test(
      'fetchItemId',
      () => () async {
            // setup
            final newsapi = NewsApiProvider();

            //expectation

            newsapi.client = MockClient((request) async {
              return Response(json.encode({'id': 123}), 200);
            });

            final ids = await newsapi.fetchItem(123);

            expect(ids, 123);
            //
          });
}
