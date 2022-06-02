import 'dart:convert';

import 'package:univalle_app/data/providers/procedures_provider.dart';
import 'package:univalle_app/models/procedure.dart';

class ProcedureRepository {
  ProcedureRepository({
    required ProceduresProvider proceduresProvider,
  }) : _provider = proceduresProvider;

  final ProceduresProvider _provider;
  Future<List<Procedure>> getProcedure() async {
    final response = await _provider.requestProcedure();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final procedures = json['proceduresTypes'] as List<dynamic>;
    return procedures.map<Procedure>(Procedure.fromJson).toList();
  }
}
