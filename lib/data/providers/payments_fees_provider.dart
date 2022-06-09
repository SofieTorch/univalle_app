import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/environment.dart';

class PaymentsFeesProvider {
  PaymentsFeesProvider({
    required StorageProvider storageProvider,
    HttpProvider? httpProvider,
  }) : _storageProvider = storageProvider {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  final StorageProvider _storageProvider;

  HttpProvider _httpProvider = HttpProvider(http.Client());

  Future<http.Response> requestPaymentFees() async {
    final endpoint = Uri.https(Environment.host, '/monthly');
    final headers = <String, String>{
      HttpHeaders.authorizationHeader: 'Basic ${_storageProvider.token}'
    };
    return _httpProvider.get(endpoint, headers: headers);
  }
}
