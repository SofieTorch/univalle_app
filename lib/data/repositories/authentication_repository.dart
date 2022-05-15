import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/environment.dart';
import 'package:univalle_app/exceptions/exceptions.dart';
import 'package:univalle_app/models/user.dart';

/// Represents the current status of authentication.
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

/// Repository which manages user authentication.
class AuthenticationRepository {
  AuthenticationRepository({
    required StorageProvider storageProvider,
    HttpProvider? httpProvider,
  }) : _storageProvider = storageProvider {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  final StorageProvider _storageProvider;
  HttpProvider _httpProvider = HttpProvider(http.Client());
  final _controller = StreamController<AuthenticationStatus>();

  /// Stream of [AuthenticationStatus] which will emit a new value
  /// when the authentication status changes.
  Stream<AuthenticationStatus> get status async* {
    yield* _controller.stream;
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  Future<User> get currentUser async {
    // As _prefs.code returns an empty string by default,
    // the user returned will be equal to User.empty.
    return User(code: _storageProvider.code);
  }

  /// Signs in with the provided [code] and [password].
  ///
  /// Emits an authenticated status if successful.
  /// Throws a [SignInFailure] if the server does not respond ok.
  Future<void> signIn({
    required String code,
    required String password,
  }) async {
    final response = await _requestSignIn(code, password);
    if (response.statusCode == 302) {
      await _storageProvider.setCode(code);
      await _storageProvider.setToken(password);
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      throw SignInFailure.fromCode(response.statusCode);
    }
  }

  /// Sends the corresponding http request to authenticate user.
  Future<http.Response> _requestSignIn(String code, String password) async {
    final body = {'cuenta': code, 'pin': int.parse(password)};
    final endpoint = Uri.https(Environment.host, '/auth');

    return _httpProvider.post(
      endpoint,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
  }

  /// Signs out the current user.
  ///
  /// Emits an unauthenticated status if successful.
  Future<void> logOut() async {
    await _storageProvider.removeCode();
    await _storageProvider.removeToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
