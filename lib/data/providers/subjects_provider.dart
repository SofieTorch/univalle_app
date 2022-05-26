import 'dart:io';

import 'package:http/http.dart';

import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/environment.dart';

/// Provides specific access to subjects related
/// data sending http requests.
class SubjectsProvider {
  SubjectsProvider({
    required StorageProvider storageProvider,
    HttpProvider? httpProvider,
  }) : _storageProvider = storageProvider {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  final StorageProvider _storageProvider;
  HttpProvider _httpProvider = HttpProvider(Client());

  /// Sends the corresponding http request to retrieve
  /// courses/subjects where the user is currently enrolled in.
  Future<Response> requestCurrentSubjects() async {
    final endpoint = Uri.https(Environment.host, '/subjects');
    final headers = <String, String>{
      HttpHeaders.authorizationHeader: 'Basic ${_storageProvider.token}'
    };

    return _httpProvider.get(endpoint, headers: headers);
  }
}
