import 'dart:convert';

import 'package:univalle_app/data/providers/discounts_provider.dart';
import 'package:univalle_app/models/models.dart';

class DiscountsRepository {
  const DiscountsRepository({
    required DiscountsProvider discountsProvider,
  }) : _provider = discountsProvider;

  final DiscountsProvider _provider;

  Future<Map<String, List<Discount>>> getDiscounts() async {
    final response = await _provider.requestDiscounts();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final discountsJson = json['disccounts'] as List<dynamic>;
    final discounts = <String, List<Discount>>{};

    for (final item in discountsJson) {
      final parsedItem = item as Map<String, dynamic>;
      final discount = Discount.fromJson(parsedItem);
      discounts.putIfAbsent(parsedItem['category'] as String, () => []);
      discounts[parsedItem['category']]?.add(discount);
    }

    return discounts;
  }
}
