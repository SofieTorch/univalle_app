import 'package:http/http.dart';
import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/environment.dart';

class DiscountsProvider {
  DiscountsProvider({
    HttpProvider? httpProvider,
  }) {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  HttpProvider _httpProvider = HttpProvider(Client());

  Future<Response> requestDiscounts() async {
    final endpoint = Uri.https(Environment.host, '/disccounts');
    return _httpProvider.get(endpoint);
  }
}
