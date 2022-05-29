import 'dart:convert';

import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/models/models.dart';

class GradesRepository {
  const GradesRepository({
    required GradesProvider gradesProvider,
    required SubjectsProvider subjectsProvider,
  })  : _gradesProvider = gradesProvider,
        _subjectsProvider = subjectsProvider;

  final GradesProvider _gradesProvider;
  final SubjectsProvider _subjectsProvider;

  Future<Map<String, List<CourseGrade>>> getGrades() async {
    final response = await _gradesProvider.requestGrades();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final courseGradesJson = json['grades'] as List<dynamic>;

    final gradesMap = <String, List<CourseGrade>>{};

    for (final item in courseGradesJson) {
      final itemParsed = item as Map<String, dynamic>;
      final courseId = itemParsed['courseId'] as int;
      final courseResponse = await _subjectsProvider.requestSubject(courseId);
      final course = Course.fromJson(jsonDecode(courseResponse.body));

      final courseGrade =
          CourseGrade.fromJson(itemParsed).copyWith(course: course);

      gradesMap.putIfAbsent(course.management, () => []);
      gradesMap[course.management]?.add(courseGrade);
    }

    return gradesMap;
  }
}
