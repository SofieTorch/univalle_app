import 'dart:io';

import 'package:http/http.dart';

import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/environment.dart';

class StudentProvider {
  StudentProvider({
    required StorageProvider storageProvider,
    HttpProvider? httpProvider,
  })  : _httpProvider = httpProvider ?? HttpProvider(Client()),
        _storageProvider = storageProvider;

  final HttpProvider _httpProvider;
  final StorageProvider _storageProvider;

  Future<Response> requestCurrentStudents() async {
    final endpoint = Uri.https(Environment.host, '/Users');
    final headers = <String, String>{
      HttpHeaders.authorizationHeader: 'Basic ${_storageProvider.token}'
    };

    return _httpProvider.get(endpoint, headers: headers);
  }
}