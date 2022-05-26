import 'dart:convert';

import 'package:univalle_app/data/providers/schedule_provider.dart';
import 'package:univalle_app/data/providers/subjects_provider.dart';
import 'package:univalle_app/models/models.dart';

class ScheduleRepository {
  const ScheduleRepository({
    required ScheduleProvider scheduleProvider,
    required SubjectsProvider subjectsProvider,
  })  : _scheduleProvider = scheduleProvider,
        _subjectsProvider = subjectsProvider;

  final ScheduleProvider _scheduleProvider;
  final SubjectsProvider _subjectsProvider;

  Future<Schedule> getSchedule() async {
    final response = await _scheduleProvider.requestSchedule();
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final classSessionsJson = json['schedule'] as List<dynamic>;

    final scheduleMap = <int, List<ClassSession>>{};

    for (final item in classSessionsJson) {
      final itemParsed = item as Map<String, dynamic>;
      final courseId = itemParsed['courseId'] as int;
      final response = await _subjectsProvider.requestSubject(courseId);
      final course = Course.fromJson(jsonDecode(response.body));

      final classSession =
          ClassSession.fromJson(itemParsed).copyWith(course: course);

      scheduleMap.putIfAbsent(itemParsed['day'] as int, () => []);
      scheduleMap[itemParsed['day']]?.add(classSession);
    }

    return Schedule(scheduleMap);
  }
}
