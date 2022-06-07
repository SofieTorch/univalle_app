import 'dart:convert';

import 'package:univalle_app/data/providers/payment_places_provider.dart';
import 'package:univalle_app/models/payment_places.dart';

class PaymentPlacesRepository {
  const PaymentPlacesRepository({
    required PaymentPlacesProvider paymentPlacesProvider,
  }) : _provider = paymentPlacesProvider;

  final PaymentPlacesProvider _provider;

  Future<List<PaymentsPlaces>> getPaymentPlaces() async {
    final response = await _provider.requestPaymentPlaces();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final paymentplaces = json['paymentPlaces'] as List<dynamic>;
    return paymentplaces.map<PaymentsPlaces>(PaymentsPlaces.fromJson).toList();
  }
}
