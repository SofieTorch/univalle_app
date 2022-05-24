import 'package:http/http.dart' as http;
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/environment.dart';

class ProceduresProvider {
  ProceduresProvider({
    HttpProvider? httpProvider,
  }) {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  HttpProvider _httpProvider = HttpProvider(http.Client());

  /// Sends the corresponding http request to procedures.
  Future<http.Response> requestProcedure() async {
    final endpoint = Uri.https(Environment.host, '/procedures');

    return _httpProvider.get(endpoint);
  }
}
