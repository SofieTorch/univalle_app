import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/environment.dart';
import 'package:univalle_app/exceptions/sign_in_failure.dart';

class MockResponse extends Mock implements Response {}

class MockHttpProvider extends Mock implements HttpProvider {}

class MockStorageProvider extends Mock implements StorageProvider {
  @override
  Future<void> setCode(String value) async {}

  @override
  Future<void> setToken(String password) async {}
}

class MockRequest {
  static String get account => 'accountTest';
  static String get pin => '0000';
  static Uri get endpoint => Uri.https(Environment.host, '/auth');

  static Map<String, Object> get body => {
        'cuenta': account,
        'pin': int.parse(pin),
      };

  static Map<String, String> get headers =>
      {'Content-Type': 'application/json'};
}

void main() {
  group('Sign in request', () {
    late AuthenticationRepository authRepository;
    late MockStorageProvider mockStorageProvider;
    late MockHttpProvider mockHttpProvider;
    late MockResponse mockResponse;

    setUp(() {
      mockStorageProvider = MockStorageProvider();
      mockHttpProvider = MockHttpProvider();
      mockResponse = MockResponse();

      when(
        () => mockHttpProvider.post(
          MockRequest.endpoint,
          body: jsonEncode(MockRequest.body),
          headers: MockRequest.headers,
        ),
      ).thenAnswer((_) => Future<Response>(() => mockResponse));

      authRepository = AuthenticationRepository(
        storageProvider: mockStorageProvider,
        httpProvider: mockHttpProvider,
      );
    });

    test('Sign in request with successful response', () {
      when(() => mockResponse.statusCode).thenReturn(302);

      final future = authRepository.signIn(
        code: MockRequest.account,
        password: MockRequest.pin,
      );

      expect(future, completes);
    });

    test('Request with 423 response throws UserLockedFailure', () {
      when(() => mockResponse.statusCode).thenReturn(423);

      final future = authRepository.signIn(
        code: MockRequest.account,
        password: MockRequest.pin,
      );

      expect(future, throwsA(equals(UserLockedFailure())));
    });

    test('Request with 404 response throws UserDoesNotExistFailure', () {
      when(() => mockResponse.statusCode).thenReturn(404);

      final future = authRepository.signIn(
        code: MockRequest.account,
        password: MockRequest.pin,
      );

      expect(future, throwsA(equals(UserDoesNotExistFailure())));
    });

    test('Request with 401 response throws IncorrectPasswordFailure', () {
      when(() => mockResponse.statusCode).thenReturn(401);

      final future = authRepository.signIn(
        code: MockRequest.account,
        password: MockRequest.pin,
      );

      expect(future, throwsA(equals(IncorrectPasswordFailure())));
    });
  });

  test('Log out removes cached session values', () {
    final mockStorageProvider = MockStorageProvider();
    final mockHttpProvider = MockHttpProvider();

    when(mockStorageProvider.removeToken).thenAnswer((_) async {});
    when(mockStorageProvider.removeCode).thenAnswer((_) async {});

    final authRepository = AuthenticationRepository(
      storageProvider: mockStorageProvider,
      httpProvider: mockHttpProvider,
    );

    final future = authRepository.logOut();

    expect(future, completes);
  });
}
