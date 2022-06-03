import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/data/providers/library_provider.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/environment.dart';

class MockStorageProvider extends Mock implements StorageProvider {}

class MockHttpProvider extends Mock implements HttpProvider {}

class MockResponse extends Mock implements Response {}

void main() {
  group('LibraryProvider', () {
    late MockStorageProvider mockStorageProvider;
    late MockHttpProvider mockHttpProvider;
    late MockResponse mockResponse;
    late LibraryProvider libraryProvider;

    setUp(() {
      mockStorageProvider = MockStorageProvider();
      mockHttpProvider = MockHttpProvider();
      mockResponse = MockResponse();

      libraryProvider = LibraryProvider(
        storageProvider: mockStorageProvider,
        httpProvider: mockHttpProvider,
      );
    });

    test('''
      requestLoans() requests loans and
      returns Response successfully.
      ''', () {
      when(() => mockStorageProvider.token).thenReturn('token:test');
      final endpoint = Uri.https(Environment.host, '/library/loans');
      final headers = <String, String>{
        HttpHeaders.authorizationHeader: 'Basic ${mockStorageProvider.token}'
      };

      when(() => mockHttpProvider.get(endpoint, headers: headers))
          .thenAnswer((_) => Future<Response>(() => mockResponse));

      final future = libraryProvider.requestLoans();

      expect(future, completion(mockResponse));
      verify(() => mockStorageProvider.token).called(2);
      verify(() => mockHttpProvider.get(endpoint, headers: headers)).called(1);
    });
  });
}
