import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/authentication/authentication.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/models/models.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUser mockUser;

  group(
    'Authentication Bloc',
    () {
      setUp(() {
        mockAuthRepository = MockAuthRepository();
      });

      test('Initial state is [AuthenticationState.unknown]', () {
        expect(
          AuthenticationBloc(authRepository: mockAuthRepository).state,
          const AuthenticationState.unknown(),
        );
      });

      blocTest<AuthenticationBloc, AuthenticationState>(
        '''
        emits [AuthenticationStatus.unauthenticated] when AuthenticationRequested is added
        and AuthenticationRepository.currentUser is empty.
        ''',
        setUp: () {
          when(() => mockAuthRepository.status).thenAnswer(
            (_) => Stream<AuthenticationStatus>.fromIterable([]),
          );

          when(() => mockAuthRepository.currentUser).thenAnswer(
            (_) async => User.empty,
          );
        },
        build: () => AuthenticationBloc(authRepository: mockAuthRepository),
        act: (AuthenticationBloc bloc) => bloc.add(AuthenticationRequested()),
        expect: () => const <AuthenticationState>[
          AuthenticationState.unauthenticated(),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        '''
        emits [AuthenticationStatus.authenticated] when AuthenticationRequested is added
        and AuthenticationRepository.currentUser is not empty.
        ''',
        setUp: () {
          mockUser = MockUser();
          when(() => mockUser.isNotEmpty).thenAnswer((_) => true);

          when(() => mockAuthRepository.status).thenAnswer(
            (_) => Stream<AuthenticationStatus>.fromIterable([]),
          );

          when(() => mockAuthRepository.currentUser).thenAnswer(
            (_) async => mockUser,
          );
        },
        build: () => AuthenticationBloc(authRepository: mockAuthRepository),
        act: (AuthenticationBloc bloc) => bloc.add(AuthenticationRequested()),
        expect: () => <AuthenticationState>[
          AuthenticationState.authenticated(mockUser),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        '''
        emits
        [AuthenticationStatus.authenticated, AuthenticationStatus.unauthenticated]
        when AuthenticationRequested is added, AuthenticationRepository.currentUser
        is not empty and AuthenticationStatus.unauthenticated is stramed later.
        ''',
        setUp: () {
          mockUser = MockUser();
          when(() => mockUser.isNotEmpty).thenAnswer((_) => true);

          when(() => mockAuthRepository.status).thenAnswer(
            (_) => Stream<AuthenticationStatus>.fromIterable([
              AuthenticationStatus.unauthenticated,
            ]),
          );

          when(() => mockAuthRepository.currentUser).thenAnswer(
            (_) async => mockUser,
          );
        },
        build: () => AuthenticationBloc(authRepository: mockAuthRepository),
        act: (AuthenticationBloc bloc) => bloc.add(AuthenticationRequested()),
        expect: () => <AuthenticationState>[
          AuthenticationState.authenticated(mockUser),
          const AuthenticationState.unauthenticated(),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        '''
        emits
        [AuthenticationStatus.unauthenticated, AuthenticationStatus.authenticated]
        when AuthenticationRequested is added, AuthenticationRepository.currentUser
        is empty and AuthenticationStatus.authenticated is streamed later,
        simulating a sign in.
        ''',
        setUp: () {
          when(() => mockAuthRepository.currentUser).thenAnswer(
            (_) async => User.empty,
          );

          when(() => mockAuthRepository.status).thenAnswer(
            (_) {
              mockUser = MockUser();
              when(() => mockUser.isNotEmpty).thenAnswer((_) => true);
              when(() => mockAuthRepository.currentUser).thenAnswer(
                (_) async => mockUser,
              );
              return Stream<AuthenticationStatus>.fromIterable([
                AuthenticationStatus.authenticated,
              ]);
            },
          );
        },
        build: () => AuthenticationBloc(authRepository: mockAuthRepository),
        act: (AuthenticationBloc bloc) => bloc.add(AuthenticationRequested()),
        expect: () => <AuthenticationState>[
          const AuthenticationState.unauthenticated(),
          AuthenticationState.authenticated(mockUser),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        '''
        emits
        [AuthenticationStatus.authenticated, AuthenticationStatus.unauthenticated]
        when AuthenticationRequested is added, AuthenticationRepository.currentUser
        is not empty and AuthenticationStatus.unauthenticated is streamed later,
        simulating a sign out.
        ''',
        setUp: () {
          mockUser = MockUser();
          when(() => mockUser.isNotEmpty).thenAnswer((_) => true);
          when(() => mockAuthRepository.currentUser).thenAnswer(
            (_) async => mockUser,
          );

          when(() => mockAuthRepository.status).thenAnswer(
            (_) {
              when(() => mockAuthRepository.currentUser).thenAnswer(
                (_) async => User.empty,
              );
              return Stream<AuthenticationStatus>.fromIterable([
                AuthenticationStatus.unauthenticated,
              ]);
            },
          );
        },
        build: () => AuthenticationBloc(authRepository: mockAuthRepository),
        act: (AuthenticationBloc bloc) => bloc.add(AuthenticationRequested()),
        expect: () => <AuthenticationState>[
          AuthenticationState.authenticated(mockUser),
          const AuthenticationState.unauthenticated(),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        '''
        emits
        [AuthenticationStatus.authenticated, AuthenticationStatus.unauthenticated]
        when [AuthenticationRequested,
        AuthenticationStatusChanged(AuthenticationStatus.unauthenticated)] are added.
        ''',
        setUp: () {
          mockUser = MockUser();
          when(() => mockUser.isNotEmpty).thenAnswer((_) => true);
          when(() => mockAuthRepository.currentUser).thenAnswer(
            (_) async => mockUser,
          );

          when(() => mockAuthRepository.status)
              .thenAnswer((_) => Stream<AuthenticationStatus>.fromIterable([]));
        },
        build: () => AuthenticationBloc(authRepository: mockAuthRepository),
        act: (AuthenticationBloc bloc) => bloc
          ..add(AuthenticationRequested())
          ..add(
            const AuthenticationStatusChanged(
              AuthenticationStatus.unauthenticated,
            ),
          ),
        expect: () => <AuthenticationState>[
          AuthenticationState.authenticated(mockUser),
          const AuthenticationState.unauthenticated(),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        '''
        emits [AuthenticationState.authenticated] and calls AuthenticationRepository.logOut
        when [AuthenticationRequested, AuthenticationLogoutRequested] are added.
        ''',
        setUp: () {
          mockUser = MockUser();
          when(() => mockUser.isNotEmpty).thenAnswer((_) => true);

          when(() => mockAuthRepository.status).thenAnswer(
            (_) => Stream<AuthenticationStatus>.fromIterable([]),
          );

          when(() => mockAuthRepository.currentUser).thenAnswer(
            (_) async => mockUser,
          );

          when(mockAuthRepository.logOut)
              .thenAnswer((_) => Future<void>(() async {}));
        },
        build: () => AuthenticationBloc(authRepository: mockAuthRepository),
        act: (bloc) => bloc
          ..add(AuthenticationRequested())
          ..add(AuthenticationLogoutRequested()),
        expect: () => <AuthenticationState>[
          AuthenticationState.authenticated(mockUser),
        ],
        verify: (_) {
          verify(mockAuthRepository.logOut).called(1);
        },
      );
    },
  );
}
