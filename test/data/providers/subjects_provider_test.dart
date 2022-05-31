import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/data/providers/subjects_provider.dart';
import 'package:univalle_app/environment.dart';

class MockStorageProvider extends Mock implements StorageProvider {}

class MockResponse extends Mock implements Response {}

class MockHttpProvider extends Mock implements HttpProvider {}

void main() {
  group('SubjectsProvider', () {
    late SubjectsProvider subjectsProvider;
    late MockStorageProvider mockStorageProvider;
    late MockHttpProvider mockHttpProvider;
    late MockResponse mockResponse;

    setUp(() {
      mockStorageProvider = MockStorageProvider();
      mockHttpProvider = MockHttpProvider();
      mockResponse = MockResponse();

      subjectsProvider = SubjectsProvider(
        storageProvider: mockStorageProvider,
        httpProvider: mockHttpProvider,
      );
    });

    test('''
      requestCurrentSubjects() requests subjects and
      returns Response successfully
      ''', () {
      when(() => mockStorageProvider.token).thenReturn('token:test');
      final endpoint = Uri.https(Environment.host, '/subjects');
      final headers = <String, String>{
        HttpHeaders.authorizationHeader: 'Basic ${mockStorageProvider.token}'
      };

      when(() => mockHttpProvider.get(endpoint, headers: headers))
          .thenAnswer((_) => Future<Response>(() => mockResponse));

      final future = subjectsProvider.requestCurrentSubjects();

      expect(future, completion(mockResponse));
      verify(() => mockStorageProvider.token).called(2);
      verify(() => mockHttpProvider.get(endpoint, headers: headers)).called(1);
    });

    test('''
      requestSubject() requests subject by id and
      returns Response successfully.
      ''', () {
      when(() => mockStorageProvider.token).thenReturn('token:test');
      final endpoint = Uri.https(
        Environment.host,
        '/subject',
        <String, String>{'courseId': 1.toString()},
      );
      final headers = <String, String>{
        HttpHeaders.authorizationHeader: 'Basic ${mockStorageProvider.token}'
      };

      when(() => mockHttpProvider.get(endpoint, headers: headers))
          .thenAnswer((_) => Future<Response>(() => mockResponse));

      final future = subjectsProvider.requestSubject(1);

      expect(future, completion(mockResponse));
      verify(() => mockStorageProvider.token).called(2);
      verify(() => mockHttpProvider.get(endpoint, headers: headers)).called(1);
    });
  });
}
