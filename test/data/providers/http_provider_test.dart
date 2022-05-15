import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:univalle_app/data/providers/http_provider.dart';

void main() {
  group('HttpProvider', () {
    test('Post method', () async {
      final client = MockClient((request) async {
        return http.Response(jsonEncode('test sucess'), 200);
      });

      final httpProvider = HttpProvider(client);
      final response = await httpProvider.post(Uri.http('localhost', '/test'));

      expect(response.statusCode, equals(200));
      expect(response.body, equals(jsonEncode('test sucess')));
    });
  });
}
