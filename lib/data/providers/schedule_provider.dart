import 'dart:io';

import 'package:http/http.dart';

import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/environment.dart';

/// Provides access to schedule related data
/// through http requests.
class ScheduleProvider {
  ScheduleProvider({
    required StorageProvider storageProvider,
    HttpProvider? httpProvider,
  }) : _storageProvider = storageProvider {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  final StorageProvider _storageProvider;
  HttpProvider _httpProvider = HttpProvider(Client());

  /// Sends an http request to get the corresponding
  /// schedule to the currently signed in student.
  Future<Response> requestSchedule() async {
    final endpoint = Uri.http(Environment.host, '/schedule');
    final headers = <String, String>{
      HttpHeaders.authorizationHeader: 'Basic ${_storageProvider.token}'
    };

    return _httpProvider.get(endpoint, headers: headers);
  }
}
