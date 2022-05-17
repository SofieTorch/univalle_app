import 'dart:convert';

import 'package:http/http.dart' as http;

/// Abstracts the http requests into a single class,
/// that way the repositories are independent of the requests
/// package that is being used.
///
/// Makes use of the package [http].
/// Receives an [http.Client] where the requests will be send.
class HttpProvider {
  const HttpProvider(this.client);
  final http.Client client;

  /// Sends an HTTP POST request with the given headers
  /// and body to the given URL.
  ///
  /// * [body] sets the body of the request. It can be a [String],
  /// a [List] or a [Map<String, String>]. If it's a String,
  /// it's encoded using [encoding] and used as the body of the request.
  /// * The content-type of the request will default to "text/plain".
  /// * If [body] is a List, it's used as a list of bytes
  /// for the body of the request.
  /// * If [body] is a Map, it's encoded as form fields
  /// using [encoding]. The content-type of the request will be set to
  /// "application/x-www-form-urlencoded"; this cannot be overridden.
  /// [encoding] defaults to [utf8].
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
