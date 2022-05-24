import 'dart:convert';

import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/data/providers/subjects_provider.dart';
import 'package:univalle_app/models/models.dart';

/// Manages all the requests related to subjects/courses.
class SubjectsRepository {
  SubjectsRepository({
    required StorageProvider storageProvider,
    SubjectsProvider? provider,
  }) {
    _provider = provider ?? SubjectsProvider(storageProvider: storageProvider);
  }

  late SubjectsProvider _provider;

  /// Retrieves courses where the student is currently enrolled in.
  Future<List<Course>> getCurrentCourses() async {
    final response = await _provider.requestCurrentSubjects();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final subjects = json['subjects'] as List<dynamic>;
    return subjects.map<Course>(Course.fromJson).toList();
  }
}
