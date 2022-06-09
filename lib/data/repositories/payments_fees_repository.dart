import 'dart:convert';

import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/models/models.dart';

class PaymentsFeesRepository {
  const PaymentsFeesRepository({
    required PaymentsFeesProvider paymentsFeesProvider,
  }) : _provider = paymentsFeesProvider;

  final PaymentsFeesProvider _provider;

  Future<List<Fees>> getFees() async {
    final response = await _provider.requestPaymentFees();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final feesJson = json['fees'] as List<dynamic>;

    final feess = <Fees>[];

    for (final item in feesJson) {
      final itemParsed = item as Map<String, dynamic>;

      final fees = Fees.fromJson(itemParsed);

      feess.add(fees);
    }

    return feess;
  }
}
