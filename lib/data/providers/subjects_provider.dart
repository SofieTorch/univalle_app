import 'dart:io';

import 'package:http/http.dart';

import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/environment.dart';

class SubjectsProvider {
  SubjectsProvider({
    required StorageProvider storageProvider,
    HttpProvider? httpProvider,
  }) : _storageProvider = storageProvider {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  final StorageProvider _storageProvider;
  HttpProvider _httpProvider = HttpProvider(Client());

  Future<Response> requestCurrentSubjects() async {
    final endpoint = Uri.https(Environment.host, '/subjects');
    final headers = <String, String>{
      HttpHeaders.authorizationHeader: 'Basic ${_storageProvider.token}'
    };

    return _httpProvider.get(endpoint, headers: headers);
  }
}
