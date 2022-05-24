import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/models/course.dart';
import 'package:univalle_app/subjects/bloc/subject_list_bloc.dart';

class MockSubjectsRepository extends Mock implements SubjectsRepository {}

class MockCourse extends Mock implements Course {}

void main() {
  group('Subject List Bloc testing', () {
    late MockSubjectsRepository mockSubjectsRepository;
    final mockCourses = <MockCourse>[];

    setUp(() {
      mockSubjectsRepository = MockSubjectsRepository();
    });

    test(
      'Initial state is [SubjectListState()]',
      () {
        expect(
          SubjectListBloc(subjectsRepository: mockSubjectsRepository).state,
          const SubjectListState(),
        );
      },
    );

    blocTest<SubjectListBloc, SubjectListState>(
      '''
      emits [
        SubjectListState(
          status: SubjectListRequestStatus.loading,
        ),
        SubjectListState(
          status: SubjectListRequestStatus.success,
          courses: mockCourses,
        )
      ] when SubjectListRequested() is added and
      SubjectsRepository returns courses successfully.
      ''',
      setUp: () {
        mockCourses.addAll([MockCourse(), MockCourse(), MockCourse()]);
        when(() => mockSubjectsRepository.getCurrentCourses()).thenAnswer(
          (invocation) => Future<List<Course>>(() => mockCourses),
        );
      },
      build: () => SubjectListBloc(subjectsRepository: mockSubjectsRepository),
      act: (SubjectListBloc bloc) => bloc.add(SubjectListRequested()),
      expect: () => <SubjectListState>[
        const SubjectListState(
          status: SubjectListRequestStatus.loading,
        ),
        SubjectListState(
          status: SubjectListRequestStatus.success,
          courses: mockCourses,
        )
      ],
      verify: (bloc) {
        verify(() => mockSubjectsRepository.getCurrentCourses()).called(1);
        expect(bloc.state.courses.length, equals(3));
      },
    );

    blocTest<SubjectListBloc, SubjectListState>(
      '''
      emits [
        SubjectListState(
          status: SubjectListRequestStatus.loading,
        ),
        SubjectListState(
          status: SubjectListRequestStatus.failure,
          errorMessage: <error message>,
        )
      ] when SubjectListRequested() is added and
      SubjectsRepository throws an error.
      ''',
      setUp: () {
        when(() => mockSubjectsRepository.getCurrentCourses())
            .thenThrow(Exception('test error message'));
      },
      build: () => SubjectListBloc(subjectsRepository: mockSubjectsRepository),
      act: (bloc) => bloc.add(SubjectListRequested()),
      expect: () => const <SubjectListState>[
        SubjectListState(
          status: SubjectListRequestStatus.loading,
        ),
        SubjectListState(
          status: SubjectListRequestStatus.failure,
          errorMessage: 'test error message',
        )
      ],
      verify: (bloc) {
        verify(() => mockSubjectsRepository.getCurrentCourses()).called(1);
        expect(bloc.state.courses, isEmpty);
      },
    );
  });
}
