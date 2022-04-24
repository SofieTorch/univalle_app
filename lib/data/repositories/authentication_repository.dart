import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/environment.dart';
import 'package:univalle_app/exceptions/exceptions.dart';
import 'package:univalle_app/models/user.dart';

/// Represents the current status of authentication.
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

/// Repository which manages user authentication.
class AuthenticationRepository {
  AuthenticationRepository({
    required StorageProvider prefs,
  }) : _prefs = prefs;

  final StorageProvider _prefs;
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
    return User(code: _prefs.code);
  }

  /// Signs in with the provided [code] and [password].
  ///
  /// Emits an authenticated status if successful.
  /// Throws a [SignInFailure] if the server does not respond ok.
  Future<void> signIn(String code, String password) async {
    final response = await _requestSignIn(code, password);
    if (response.statusCode == 200) {
      await _prefs.setCode(code);
      await _prefs.setToken(password);
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      throw SignInFailure.fromCode(response.statusCode);
    }
  }

  /// Sends the corresponding http request to authenticate user.
  Future<http.Response> _requestSignIn(String code, String password) async {
    final queryParams = {'code': code, 'password': password};
    final endpoint = Uri.http(
      Environment.host,
      '/auth',
      queryParams,
    );

    return http.get(endpoint);
  }

  /// Signs out the current user.
  ///
  /// Emits an unauthenticated status if successful.
  Future<void> logOut() async {
    await _prefs.removeCode();
    await _prefs.removeToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
