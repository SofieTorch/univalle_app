import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:univalle_app/exceptions/exceptions.dart';

/// Provides specific access to cache, using [SharedPreferences].
///
/// To avoid typing errors when writing, obtaining or deleting
/// values from persistent storage, this provider sets specific
/// methods to manipulate each value.
class StorageProvider {
  StorageProvider({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  final String _codeKey = 'code';
  final String _tokenKey = 'token';

  /// Saves a string [value] to persistent storage,
  /// which later can be accessed with its [key].
  Future<void> _saveString(String key, String value) async {
    final success = await _prefs.setString(key, value);
    if (!success) throw const StorageSaveFailure();
  }

  /// Removes a value from persistent storage given its [key].
  Future<void> _removeValue(String key) async {
    final success = await _prefs.remove(key);
    if (!success) throw const StorageRemoveFailure();
  }

  /// Saves the given student code value in storage.
  Future<void> setCode(String value) async {
    await _saveString(_codeKey, value);
  }

  /// Saves the authentication access token
  /// in storage, given the password.
  Future<void> setToken(String password) async {
    await _saveString(
      _tokenKey,
      base64Encode(utf8.encode('$code:$password')),
    );
  }

  /// Removes the student code's value and key from storage.
  Future<void> removeCode() => _removeValue(_codeKey);

  /// Removes the token's value and key from storage.
  Future<void> removeToken() => _removeValue(_tokenKey);

  /// Returns the student code saved in storage if found,
  /// otherwise returns an empty string.
  String get code => _prefs.getString(_codeKey) ?? '';

  /// Returns the token saved in storage if found,
  /// otherwise returns an empty string.
  String get token => _prefs.getString(_tokenKey) ?? '';
}
