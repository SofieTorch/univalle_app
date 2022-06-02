import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/schedule_repository.dart';
import 'package:univalle_app/models/class_session.dart';
import 'package:univalle_app/models/course.dart';
import 'package:univalle_app/models/schedule.dart';

class MockSubjectsProvider extends Mock implements SubjectsProvider {}

class MockScheduleProvider extends Mock implements ScheduleProvider {}

class MockResponse extends Mock implements Response {}

void main() {
  group('ScheduleRepository', () {
    late ScheduleRepository repository;
    late MockScheduleProvider mockScheduleProvider;
    late MockSubjectsProvider mockSubjectsProvider;

    setUp(() {
      mockScheduleProvider = MockScheduleProvider();
      mockSubjectsProvider = MockSubjectsProvider();

      repository = ScheduleRepository(
        scheduleProvider: mockScheduleProvider,
        subjectsProvider: mockSubjectsProvider,
      );
    });

    test('''
      getSchedule() request returns Schedule successfully.
      ''', () {
      const scheduleJson = '''
        {
          "schedule": [
            {
              "classroom": "S407",
              "courseId": 326,
              "day": 1,
              "end": "09:25",
              "start": "08:35"
            },
            {
              "classroom": "T206",
              "courseId": 327,
              "day": 2,
              "end": "09:25",
              "start": "08:35"
            }
          ]
        }
      ''';

      const course326 = '''
        {
          "group": "A",
          "id": 326,
          "management": "1-2022",
          "name": "Estadística computacional",
          "teacher": "Oscar Contreras Carrasco"
        }
      ''';

      const course327 = '''
        {
          "group": "A",
          "id": 327,
          "management": "1-2022",
          "name": "Procesamiento digital de imágenes",
          "teacher": "Gastón Silva"
        }
      ''';

      final schedule = Schedule({
        1: [
          ClassSession(
            course: Course.fromJson(jsonDecode(course326)),
            classroom: 'S407',
            endTime: DateTime(0, 0, 0, 9, 25),
            startTime: DateTime(0, 0, 0, 8, 35),
          ),
        ],
        2: [
          ClassSession(
            course: Course.fromJson(jsonDecode(course327)),
            classroom: 'T206',
            endTime: DateTime(0, 0, 0, 9, 25),
            startTime: DateTime(0, 0, 0, 8, 35),
          ),
        ],
      });

      when(() => mockSubjectsProvider.requestSubject(326))
          .thenAnswer((_) => Future<Response>(() => Response(course326, 200)));
      when(() => mockSubjectsProvider.requestSubject(327))
          .thenAnswer((_) => Future<Response>(() => Response(course327, 200)));
      when(() => mockScheduleProvider.requestSchedule()).thenAnswer(
        (_) => Future<Response>(() => Response(scheduleJson, 200)),
      );

      final future = repository.getSchedule();
      expect(future, completion(equals(schedule)));
    });

    test(
      '''
      getSchedule() request throws an error
      when respose code is not 200.
      ''',
      () {
        when(() => mockScheduleProvider.requestSchedule()).thenAnswer(
          (_) => Future<Response>(() => Response('', 500)),
        );

        expect(repository.getSchedule(), throwsException);
      },
    );
  });
}
