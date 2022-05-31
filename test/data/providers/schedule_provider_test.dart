import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/environment.dart';

class MockStorageProvider extends Mock implements StorageProvider {}

class MockResponse extends Mock implements Response {}

class MockHttpProvider extends Mock implements HttpProvider {}

void main() {
  group('ScheduleProvider', () {
    late ScheduleProvider scheduleProvider;
    late MockStorageProvider mockStorageProvider;
    late MockHttpProvider mockHttpProvider;
    late MockResponse mockResponse;

    setUp(() {
      mockStorageProvider = MockStorageProvider();
      mockHttpProvider = MockHttpProvider();
      mockResponse = MockResponse();

      scheduleProvider = ScheduleProvider(
        storageProvider: mockStorageProvider,
        httpProvider: mockHttpProvider,
      );
    });

    test('''
      requestSchedule() requests schedule and
      returns Response successfully.
      ''', () {
      when(() => mockStorageProvider.token).thenReturn('token:test');
      final endpoint = Uri.https(Environment.host, '/schedule');
      final headers = <String, String>{
        HttpHeaders.authorizationHeader: 'Basic ${mockStorageProvider.token}'
      };

      when(() => mockHttpProvider.get(endpoint, headers: headers))
          .thenAnswer((_) => Future<Response>(() => mockResponse));

      final future = scheduleProvider.requestSchedule();

      expect(future, completion(mockResponse));
      verify(() => mockStorageProvider.token).called(2);
      verify(() => mockHttpProvider.get(endpoint, headers: headers)).called(1);
    });
  });
}
