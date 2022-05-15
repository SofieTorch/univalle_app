import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpProvider {
  const HttpProvider(this.client);
  final http.Client client;

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    return client.post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }
}
