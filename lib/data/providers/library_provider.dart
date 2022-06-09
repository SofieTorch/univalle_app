import 'dart:io';

import 'package:http/http.dart';

import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/environment.dart';

class LibraryProvider {
  LibraryProvider({
    required StorageProvider storageProvider,
    HttpProvider? httpProvider,
  }) : _storageProvider = storageProvider {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  HttpProvider _httpProvider = HttpProvider(Client());
  final StorageProvider _storageProvider;

  Future<Response> requestLoans() async {
    final endpoint = Uri.https(Environment.host, '/library/loans');
    final headers = <String, String>{
      HttpHeaders.authorizationHeader: 'Basic ${_storageProvider.token}'
    };

    return _httpProvider.get(endpoint, headers: headers);
  }

  Future<Response> searchBook(String searchText) async {
    final params = {'content': searchText};
    final endpoint = Uri.https(Environment.host, '/library/search', params);
    final headers = <String, String>{
      HttpHeaders.authorizationHeader: 'Basic ${_storageProvider.token}'
    };

    return _httpProvider.get(endpoint, headers: headers);
  }
}
