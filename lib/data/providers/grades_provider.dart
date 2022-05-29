import 'dart:io';

import 'package:http/http.dart';

import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/environment.dart';

/// Sends http requests for grades related data.
class GradesProvider {
  GradesProvider({
    required StorageProvider storageProvider,
    HttpProvider? httpProvider,
  }) : _storageProvider = storageProvider {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  final StorageProvider _storageProvider;
  HttpProvider _httpProvider = HttpProvider(Client());

  /// Sends an http request to get the corresponding grades
  /// from the currently signed in student.
  Future<Response> requestGrades() async {
    final endpoint = Uri.https(Environment.host, '/grades');
    final headers = <String, String>{
      HttpHeaders.authorizationHeader: 'Basic ${_storageProvider.token}'
    };

    return _httpProvider.get(endpoint, headers: headers);
  }
}
