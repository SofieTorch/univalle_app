import 'dart:convert';

import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/models/document.dart';

class DocumentsRepository {
  const DocumentsRepository({required DocumentsProvider documentsProvider})
      : _provider = documentsProvider;

  final DocumentsProvider _provider;

  Future<List<Document>> getDocuments() async {
    final response = await _provider.requestDocuments();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final documentsJson = json['documents'] as List<dynamic>;
    final documents = <Document>[];

    for (final item in documentsJson) {
      final itemParsed = item as Map<String, dynamic>;
      final document = Document.fromJson(itemParsed);
      documents.add(document);
    }

    return documents;
  }
}
