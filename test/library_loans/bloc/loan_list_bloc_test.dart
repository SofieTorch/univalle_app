import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/repositories/library_repository.dart';
import 'package:univalle_app/library_loans/bloc/loan_list_bloc.dart';
import 'package:univalle_app/models/models.dart';

class MockLibraryRepository extends Mock implements LibraryRepository {}

void main() {
  group('LoanListBloc', () {
    late MockLibraryRepository mockLibraryRepository;
    late List<Loan> loans;

    setUp(() {
      mockLibraryRepository = MockLibraryRepository();
      loans = [];
    });

    test('Initial state is [LoanListState()]', () {
      expect(
        LoanListBloc(libraryRepository: mockLibraryRepository).state,
        equals(const LoanListState()),
      );
    });

    blocTest<LoanListBloc, LoanListState>(
      '''
      emits [
        LoanListState(
          status: LoanListRequestStatus.loading,
        ),
        LoanListState(
          status: LoanListRequestStatus.success,
          loans: [loans],
        ),
      ] when LoanListRequested() is added and
      LibraryRepository returns loans successfully.
      ''',
      setUp: () {
        when(() => mockLibraryRepository.getLoans())
            .thenAnswer((_) => Future<List<Loan>>(() => loans));
      },
      build: () => LoanListBloc(libraryRepository: mockLibraryRepository),
      act: (bloc) => bloc.add(LoanListRequested()),
      expect: () => <LoanListState>[
        const LoanListState(
          status: LoanListRequestStatus.loading,
        ),
        LoanListState(
          status: LoanListRequestStatus.success,
          loans: loans,
        ),
      ],
    );

    blocTest<LoanListBloc, LoanListState>(
      '''
        emits [
          LoanListState(
            status: LoanListRequestStatus.loading,
          ),
          LoanListState(
            status: LoanListRequestStatus.failure,
            errorMessage: [errorMessage],
          ),
        ] when LoanListRequested() is added and
        LibraryRepository throws an exception.
        ''',
      setUp: () {
        when(() => mockLibraryRepository.getLoans())
            .thenThrow(Exception('Error message test'));
      },
      build: () => LoanListBloc(libraryRepository: mockLibraryRepository),
      act: (bloc) => bloc.add(LoanListRequested()),
      expect: () => const <LoanListState>[
        LoanListState(
          status: LoanListRequestStatus.loading,
        ),
        LoanListState(
          status: LoanListRequestStatus.failure,
          errorMessage: 'Exception: Error message test',
        ),
      ],
    );
  });
}
