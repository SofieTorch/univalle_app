import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/data/providers/subjects_provider.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/models/course.dart';

class MockStorageProvider extends Mock implements StorageProvider {}

class MockSubjectsProvider extends Mock implements SubjectsProvider {}

class MockResponse extends Mock implements Response {}

void main() {
  group('SubjectsRepository', () {
    late SubjectsRepository repository;
    late MockSubjectsProvider mockSubjectsProvider;
    final courses = <Course>[];

    setUp(() {
      mockSubjectsProvider = MockSubjectsProvider();

      repository = SubjectsRepository(
        storageProvider: MockStorageProvider(),
        provider: mockSubjectsProvider,
      );
    });

    test(
      '''
      getCurrentCourses() request returns List<Course> successfully
      ''',
      () {
        courses
          ..add(const Course(id: 1, group: 'A', subject: 'test1'))
          ..add(const Course(id: 2, group: 'B', subject: 'test2'));

        const coursesJson = '''
          {
            "subjects": [
              {
                "id": 1,
                "name": "test1",
                "group": "A",
                "teacher": "",
                "management": ""
              },
              {
                "id": 2,
                "name": "test2",
                "group": "B",
                "teacher": "",
                "management": ""
              }
            ]
          }
        ''';
        when(() => mockSubjectsProvider.requestCurrentSubjects()).thenAnswer(
          (_) => Future<Response>(() => Response(coursesJson, 200)),
        );

        final future = repository.getCurrentCourses();
        expect(future, completion(equals(courses)));
      },
    );

    test(
      '''
      getCurrentCourses() request throws an error
      when respose code is not 200.
      ''',
      () {
        when(() => mockSubjectsProvider.requestCurrentSubjects()).thenAnswer(
          (_) => Future<Response>(() => Response('', 500)),
        );

        expect(repository.getCurrentCourses(), throwsException);
      },
    );
  });
}
