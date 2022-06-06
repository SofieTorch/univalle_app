import 'package:http/http.dart' as http;
import 'package:univalle_app/data/providers/http_provider.dart';
import 'package:univalle_app/environment.dart';

class PaymentPlacesProvider {
  PaymentPlacesProvider({
    HttpProvider? httpProvider,
  }) {
    _httpProvider = httpProvider ?? _httpProvider;
  }

  HttpProvider _httpProvider = HttpProvider(http.Client());

  Future<http.Response> requestPaymentPlaces() async {
    final endpoint = Uri.https(Environment.host, '/payment_places');
    return _httpProvider.get(endpoint);
  }
}
