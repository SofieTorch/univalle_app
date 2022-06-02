import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/grades_provider.dart';
import 'package:univalle_app/data/providers/subjects_provider.dart';
import 'package:univalle_app/data/repositories/grades_repository.dart';
import 'package:univalle_app/models/models.dart';

class MockSubjectsProvider extends Mock implements SubjectsProvider {}

class MockGradesProvider extends Mock implements GradesProvider {}

class MockResponse extends Mock implements Response {}

void main() {
  group('GradesRepository', () {
    late GradesRepository repository;
    late MockGradesProvider mockGradesProvider;
    late MockSubjectsProvider mockSubjectsProvider;

    setUp(() {
      mockGradesProvider = MockGradesProvider();
      mockSubjectsProvider = MockSubjectsProvider();

      repository = GradesRepository(
        gradesProvider: mockGradesProvider,
        subjectsProvider: mockSubjectsProvider,
      );
    });

    test(
      '''
      getGrades() request return Map<String, List<CourseGrades>> successfully.
      ''',
      () {
        const gradesJson = '''
        {
          "grades": [
            {
              "courseId": 257,
              "final": 100.0,
              "partials": [
                  100.0,
                  100.0
              ],
              "semestral": 100.0
            },
            {
              "courseId": 219,
              "final": 100.0,
              "partials": [
                  100.0,
                  80.0
              ],
              "semestral": 93.0
            }
          ]
        }
        ''';

        const course219 = '''
        {
          "group": "A",
          "id": 219,
          "management": "1-2020",
          "name": "Programacion I",
          "teacher": "Pavel Caceres"
        }
      ''';

        const course257 = '''
        {
          "group": "A",
          "id": 257,
          "management": "2-2020",
          "name": "Programacion web",
          "teacher": "Oscar Contreras"
        }
      ''';

        final grades = {
          '2-2020': [
            CourseGrade(
              course: Course.fromJson(jsonDecode(course257)),
              finalExam: 100,
              partials: const [100.0, 100.0],
              semestralGrade: 100,
            ),
          ],
          '1-2020': [
            CourseGrade(
              course: Course.fromJson(jsonDecode(course219)),
              finalExam: 100,
              partials: const [100.0, 80.0],
              semestralGrade: 93,
            ),
          ],
        };

        when(() => mockSubjectsProvider.requestSubject(219)).thenAnswer(
          (_) => Future<Response>(() => Response(course219, 200)),
        );
        when(() => mockSubjectsProvider.requestSubject(257)).thenAnswer(
          (_) => Future<Response>(() => Response(course257, 200)),
        );
        when(() => mockGradesProvider.requestGrades()).thenAnswer(
          (_) => Future<Response>(() => Response(gradesJson, 200)),
        );

        final future = repository.getGrades();
        expect(future, completion(equals(grades)));
      },
    );

    test('''
      getGrades() request throws an error
      when response code is not 200.
      ''', () {
      when(() => mockGradesProvider.requestGrades()).thenAnswer(
        (invocation) => Future<Response>(() => Response('', 500)),
      );

      expect(repository.getGrades(), throwsException);
    });
  });
}
