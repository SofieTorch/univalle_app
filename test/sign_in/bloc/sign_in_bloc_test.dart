import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/repositories/authentication_repository.dart';
import 'package:univalle_app/exceptions/sign_in_failure.dart';
import 'package:univalle_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:univalle_app/sign_in/models/models.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository {}

void main() {
  group(
    'Sign In Bloc testing',
    () {
      late MockAuthRepository mockAuthRepository;

      setUp(() {
        mockAuthRepository = MockAuthRepository();
      });

      test(
        'Initial state is [SignInState()]',
        () {
          expect(
            SignInBloc(authRepository: MockAuthRepository()).state,
            const SignInState(),
          );
        },
      );

      blocTest<SignInBloc, SignInState>(
        '''
        emits [SignInState({
          status: FormzStatus.invalid,
          studentCode: StudentCode.dirty('   '),
        })] when [SignInStudentCodeChanged('   ')] is added.
        ''',
        build: () => SignInBloc(authRepository: MockAuthRepository()),
        act: (SignInBloc bloc) =>
            bloc.add(const SignInStudentCodeChanged('   ')),
        expect: () => const <SignInState>[
          SignInState(
            status: FormzStatus.invalid,
            studentCode: StudentCode.dirty('   '),
          ),
        ],
      );

      blocTest<SignInBloc, SignInState>(
        '''
        emits [SignInState({
          status: FormzStatus.invalid,
          password: Password.dirty('   '),
        })] when [SignInPasswordChanged('   ')] is added.
        ''',
        build: () => SignInBloc(authRepository: MockAuthRepository()),
        act: (SignInBloc bloc) => bloc.add(const SignInPasswordChanged('   ')),
        expect: () => const <SignInState>[
          SignInState(
            status: FormzStatus.invalid,
            password: Password.dirty('   '),
          ),
        ],
      );

      blocTest<SignInBloc, SignInState>(
        '''
        emits [SignInState(status: FormzStatus.valid)]
        when SignInStudentCodeChanged and SignInPasswordChanged
        are added and its values are not empty.
        ''',
        build: () => SignInBloc(authRepository: MockAuthRepository()),
        seed: () => const SignInState(
          status: FormzStatus.invalid,
          studentCode: StudentCode.dirty('TCS0028814'),
        ),
        act: (SignInBloc bloc) => bloc
          ..add(const SignInStudentCodeChanged('TCS0028814'))
          ..add(const SignInPasswordChanged('144963')),
        expect: () => const <SignInState>[
          SignInState(
            status: FormzStatus.valid,
            studentCode: StudentCode.dirty('TCS0028814'),
            password: Password.dirty('144963'),
          ),
        ],
      );

      blocTest<SignInBloc, SignInState>(
        '''
        emits [SignInState(status: FormzStatus.submissionInProgress),
        SignInState(status: FormzStatus.submissionFailure)]
        after [SignInSubmitted()] is added
        and AuthenticationRepositoy throws an error.
        ''',
        setUp: () {
          when(
            () => mockAuthRepository.signIn(
              code: 'TCS0028814',
              password: '144963',
            ),
          ).thenThrow(UserLockedFailure());
        },
        build: () => SignInBloc(authRepository: mockAuthRepository),
        seed: () => const SignInState(
          status: FormzStatus.valid,
          studentCode: StudentCode.dirty('TCS0028814'),
          password: Password.dirty('144963'),
        ),
        act: (SignInBloc bloc) => bloc..add(const SignInSubmitted()),
        skip: 1,
        expect: () => <SignInState>[
          SignInState(
            status: FormzStatus.submissionFailure,
            studentCode: const StudentCode.dirty('TCS0028814'),
            password: const Password.dirty('144963'),
            error: UserLockedFailure(),
          ),
        ],
        verify: (_) {
          verify(
            () => mockAuthRepository.signIn(
              code: 'TCS0028814',
              password: '144963',
            ),
          ).called(1);
        },
      );

      blocTest<SignInBloc, SignInState>(
        '''
        emits [SignInState(status: FormzStatus.submissionInProgress),
        SignInState(status: FormzStatus.submissionFailure)]
        after [SignInSubmitted()] is added
        and AuthenticationRepositoy throws an error.
        ''',
        setUp: () {
          when(
            () => mockAuthRepository.signIn(
              code: 'TCS0028814',
              password: '144963',
            ),
          ).thenThrow(Exception());
        },
        build: () => SignInBloc(authRepository: mockAuthRepository),
        seed: () => const SignInState(
          status: FormzStatus.valid,
          studentCode: StudentCode.dirty('TCS0028814'),
          password: Password.dirty('144963'),
        ),
        act: (SignInBloc bloc) => bloc..add(const SignInSubmitted()),
        skip: 1,
        expect: () => const <SignInState>[
          SignInState(
            status: FormzStatus.submissionFailure,
            studentCode: StudentCode.dirty('TCS0028814'),
            password: Password.dirty('144963'),
            error: SignInFailure(),
          ),
        ],
        verify: (_) {
          verify(
            () => mockAuthRepository.signIn(
              code: 'TCS0028814',
              password: '144963',
            ),
          ).called(1);
        },
      );

      blocTest<SignInBloc, SignInState>(
        '''
         emits [SignInState(status: FormzStatus.submissionInProgress),
        SignInState(status: FormzStatus.submissionSuccess)]
        after [SignInSubmitted()] is added
        and AuthenticationRepositoy throws an error.
        ''',
        setUp: () {
          when(
            () => mockAuthRepository.signIn(
              code: 'TCS0028814',
              password: '144963',
            ),
          ).thenAnswer((invocation) => Future<void>(() async {}));
        },
        build: () => SignInBloc(authRepository: mockAuthRepository),
        seed: () => const SignInState(
          status: FormzStatus.valid,
          studentCode: StudentCode.dirty('TCS0028814'),
          password: Password.dirty('144963'),
        ),
        act: (SignInBloc bloc) => bloc..add(const SignInSubmitted()),
        expect: () => const <SignInState>[
          SignInState(
            status: FormzStatus.submissionInProgress,
            studentCode: StudentCode.dirty('TCS0028814'),
            password: Password.dirty('144963'),
          ),
          SignInState(
            status: FormzStatus.submissionSuccess,
            studentCode: StudentCode.dirty('TCS0028814'),
            password: Password.dirty('144963'),
          ),
        ],
        verify: (_) {
          verify(
            () => mockAuthRepository.signIn(
              code: 'TCS0028814',
              password: '144963',
            ),
          ).called(1);
        },
      );
    },
  );
}
