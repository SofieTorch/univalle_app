import 'dart:io';

import 'package:http/http.dart';
import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/environment.dart';

class DocumentsProvider {
  DocumentsProvider({
    required StorageProvider storageProvider,
    HttpProvider? httpProvider,
  }) : _storageProvider = storageProvider {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  HttpProvider _httpProvider = HttpProvider(Client());
  final StorageProvider _storageProvider;

  Future<Response> requestDocuments() {
    final endpoint = Uri.https(Environment.host, '/documents');
    final headers = <String, String>{
      HttpHeaders.authorizationHeader: 'Basic ${_storageProvider.token}'
    };

    return _httpProvider.get(endpoint, headers: headers);
  }
}
