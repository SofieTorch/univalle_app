import 'package:http/http.dart';
import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/environment.dart';

class CampusProvider {
  CampusProvider({
    HttpProvider? httpProvider,
  }) {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  HttpProvider _httpProvider = HttpProvider(Client());

  Future<Response> requestPlaces() {
    final endpoint = Uri.https(Environment.host, '/campus_places');
    return _httpProvider.get(endpoint);
  }
}
