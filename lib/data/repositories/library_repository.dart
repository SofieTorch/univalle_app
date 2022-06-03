import 'dart:convert';

import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/models/models.dart';

class LibraryRepository {
  const LibraryRepository({
    required LibraryProvider libraryProvider,
  }) : _provider = libraryProvider;

  final LibraryProvider _provider;

  Future<List<Loan>> getLoans() async {
    final response = await _provider.requestLoans();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final loansJson = json['loans'] as List<dynamic>;

    final loans = <Loan>[];

    for (final item in loansJson) {
      final itemParsed = item as Map<String, dynamic>;
      final campus = Campus.fromJson(itemParsed['campus']);
      final book = Book.fromJson(itemParsed['book'], campus);
      final loan = Loan.fromJson(itemParsed, book);

      loans.add(loan);
    }

    return loans;
  }
}
