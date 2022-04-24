import 'package:http/http.dart' as http;
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/environment.dart';

class StudentProvider {
  const StudentProvider({required StorageProvider prefs}) : _prefs = prefs;
  final StorageProvider _prefs;

  Future<http.Response> getStudent(String code) {
    final queryParams = {'code': code};
    final endpoint = Uri.http(
      Environment.host,
      '/st',
      queryParams,
    );

    return http.get(
      endpoint,
      headers: {
        'authorization': 'Basic ${_prefs.token}',
      },
    );
  }
}
