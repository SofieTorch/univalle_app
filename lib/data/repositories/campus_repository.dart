import 'dart:convert';

import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/models/models.dart';

class CampusRepository {
  const CampusRepository({
    required CampusProvider campusProvider,
  }) : _provider = campusProvider;

  final CampusProvider _provider;

  Future<Map<Headquarter, List<Place>>> getPlaces() async {
    final response = await _provider.requestPlaces();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final placesJson = json['places'] as List<dynamic>;
    final places = <Headquarter, List<Place>>{};

    for (final item in placesJson) {
      final parsedItem = item as Map<String, dynamic>;
      final headquarter = Headquarter.fromJson(parsedItem['headquarter']);
      final campus = Campus.fromJson(parsedItem['campus']);
      final place = Place.fromJson(parsedItem, campus);

      places.putIfAbsent(headquarter, () => []);
      places[headquarter]?.add(place);
    }

    return places;
  }
}
