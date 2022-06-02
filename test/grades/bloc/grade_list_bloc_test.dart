import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/repositories/grades_repository.dart';
import 'package:univalle_app/grades/bloc/grade_list_bloc.dart';
import 'package:univalle_app/models/models.dart';

class MockGradesRepository extends Mock implements GradesRepository {}

void main() {
  group('GradeListBloc', () {
    late MockGradesRepository mockGradesRepository;
    late Map<String, List<CourseGrade>> grades;

    setUp(() {
      mockGradesRepository = MockGradesRepository();
      grades = {
        '1-2022': [
          const CourseGrade(
            course: Course(subject: 'Subject test 1'),
            finalExam: 100,
            partials: [100.0, 80.0],
            semestralGrade: 93,
          ),
        ],
        '2-2021': [
          const CourseGrade(
            course: Course(subject: 'Subject test 2'),
            finalExam: 100,
            partials: [100.0, 100.0],
            semestralGrade: 100,
          ),
        ],
      };
    });

    test('Initial state is [GradeListState()]', () {
      expect(
        GradeListBloc(gradesRepository: mockGradesRepository).state,
        equals(const GradeListState()),
      );
    });

    blocTest<GradeListBloc, GradeListState>(
      '''
      emits [
        GradeListState(
          status: GradeListRequestStatus.loading,
        ),
        GradeListState(
          status: GradeListRequestStatus.failure,
          errorMessage: <ErrorMessage>,
        )
      ] when GradeListRequested is added and
      GradesRepository throws an error.
      ''',
      setUp: () {
        when(() => mockGradesRepository.getGrades())
            .thenThrow(Exception('Error message test'));
      },
      build: () => GradeListBloc(gradesRepository: mockGradesRepository),
      act: (bloc) => bloc.add(const GradeListRequested()),
      expect: () => const <GradeListState>[
        GradeListState(
          status: GradeListRequestStatus.loading,
        ),
        GradeListState(
          status: GradeListRequestStatus.failure,
          errorMessage: 'Exception: Error message test',
        )
      ],
      verify: (bloc) {
        verify(() => mockGradesRepository.getGrades()).called(1);
        expect(bloc.state.grades, isEmpty);
      },
    );

    blocTest<GradeListBloc, GradeListState>(
      '''
      emits [
        GradeListState(
          status: GradeListRequestStatus.loading,
        ),
        GradeListState(
          status: GradeListRequestStatus.success,
          grades: [Map<String, List<CourseGrade>>],
          selectedManagement: grades.first,
        )
      ] when GradeListRequested() is added and
      GradesRepository returns grades successfully.
      ''',
      setUp: () {
        when(() => mockGradesRepository.getGrades()).thenAnswer(
          (_) => Future<Map<String, List<CourseGrade>>>(() => grades),
        );
      },
      build: () => GradeListBloc(gradesRepository: mockGradesRepository),
      act: (bloc) => bloc.add(const GradeListRequested()),
      expect: () => <GradeListState>[
        const GradeListState(
          status: GradeListRequestStatus.loading,
        ),
        GradeListState(
          status: GradeListRequestStatus.success,
          grades: grades,
          selectedManagement: '1-2022',
        )
      ],
    );

    blocTest<GradeListBloc, GradeListState>(
      '''
      emits [
        GradeListState(
          selectedManagement: '2-2021',
        )
      ] when ManagementChanged('2-2021') is added.
      ''',
      seed: () => GradeListState(
        status: GradeListRequestStatus.success,
        grades: grades,
        selectedManagement: '1-2022',
      ),
      build: () => GradeListBloc(gradesRepository: mockGradesRepository),
      act: (bloc) => bloc.add(const ManagementChanged('2-2021')),
      expect: () => <GradeListState>[
        GradeListState(
          status: GradeListRequestStatus.success,
          grades: grades,
          selectedManagement: '2-2021',
        )
      ],
    );
  });
}
