import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/repositories/procedures_repository.dart';
import 'package:univalle_app/models/procedure.dart';
import 'package:univalle_app/procedures/bloc/procedures_bloc.dart';

class MockProcedureRepository extends Mock implements ProcedureRepository {}

class MockProcedure extends Mock implements Procedure {}

void main() {
  group('Procedures bloc', () {
    late MockProcedureRepository mockProcedureRepository;
    late List<Procedure> procedures;

    setUp(() {
      mockProcedureRepository = MockProcedureRepository();
      procedures = [
        const Procedure(name: 'name 1'),
        const Procedure(name: 'name 2'),
        const Procedure(name: 'name 3'),
      ];
    });
    test(
      'Initial state is [ProceduresState()]',
      () {
        expect(
          ProceduresBloc(procedureRepository: mockProcedureRepository).state,
          equals(const ProceduresState()),
        );
      },
    );
    blocTest<ProceduresBloc, ProceduresState>(
      '''
      emits [
        ProceduresState(
          status: ProcedureListRequestStatus.loading,
        ),
        ProceduresState(
          status: ProcedureListRequestStatus.success,
          procedures: mockProcedure,
        ),
      ] when ProcedureListRequested() is added and
      ProcedureRepository returns procedure successfully.
      ''',
      setUp: () {
        when(() => mockProcedureRepository.getProcedure())
            .thenAnswer((_) => Future<List<Procedure>>(() => procedures));
      },
      build: () => ProceduresBloc(procedureRepository: mockProcedureRepository),
      act: (bloc) => bloc.add(ProcedureListRequested()),
      expect: () => <ProceduresState>[
        const ProceduresState(
          status: ProcedureListRequestStatus.loading,
        ),
        ProceduresState(
          status: ProcedureListRequestStatus.success,
          procedures: procedures,
        ),
      ],
    );

    blocTest<ProceduresBloc, ProceduresState>(
      '''
      emits [
        ProceduresState(
          status: ProcedureListRequestStatus.loading,
        ),
        ProceduresState(
          status: ProcedureListRequestStatus.failure,
          procedures: <error message>,
        ),
      ] when ProcedureListRequested() is added and
      ProcedureRepository throws an error.
      ''',
      setUp: () {
        when(() => mockProcedureRepository.getProcedure())
            .thenThrow(Exception('test error message'));
      },
      build: () => ProceduresBloc(procedureRepository: mockProcedureRepository),
      act: (bloc) => bloc.add(ProcedureListRequested()),
      expect: () => const <ProceduresState>[
        ProceduresState(
          status: ProcedureListRequestStatus.loading,
        ),
        ProceduresState(
          status: ProcedureListRequestStatus.failure,
          errorMessage: 'Exception: test error message',
        ),
      ],
      verify: (bloc) {
        verify(() => mockProcedureRepository.getProcedure()).called(1);
        expect(bloc.state.procedures, isEmpty);
      },
    );
  });
}
