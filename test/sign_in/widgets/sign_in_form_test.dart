import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/exceptions/sign_in_failure.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/sign_in/sign_in.dart';

class MockSignInBloc extends MockBloc<SignInEvent, SignInState>
    implements SignInBloc {}

void main() {
  group('Sign in form elements', () {
    late MockSignInBloc signInBloc;

    setUp(() {
      signInBloc = MockSignInBloc();
      when(() => signInBloc.state).thenReturn(const SignInState());
    });

    testWidgets(
      '''
      Adds [SignInStudentCodeChanged] when Student code text field is changed.
      ''',
      (tester) async {
        when(() => signInBloc.add(const SignInStudentCodeChanged('codetest')))
            .thenAnswer((_) {});

        await tester.pumpApp(bloc: signInBloc);
        await tester.pump();
        await tester.enterText(
          find.byKey(const Key('signinForm_studentCode_textField')),
          'codetest',
        );
        await tester.pump();

        verify(() => signInBloc.add(const SignInStudentCodeChanged('codetest')))
            .called(1);
      },
    );

    testWidgets(
      '''
      Adds [SignInPasswordChanged] when Password text field is changed.
      ''',
      (tester) async {
        when(() => signInBloc.add(const SignInPasswordChanged('codetest')))
            .thenAnswer((_) {});

        await tester.pumpApp(bloc: signInBloc);
        await tester.pump();

        await tester.enterText(
          find.byKey(const Key('signinForm_password_textField')),
          'passtest',
        );

        await tester.pump();

        verify(() => signInBloc.add(const SignInPasswordChanged('passtest')))
            .called(1);
      },
    );

    testWidgets(
      '''
      Adds [SignInSubmitted] when sumbission button is tapped.
      ''',
      (tester) async {
        whenListen(
          signInBloc,
          Stream<SignInState>.fromIterable([
            const SignInState(
              status: FormzStatus.valid,
            ),
          ]),
        );

        when(() => signInBloc.add(const SignInSubmitted())).thenAnswer((_) {});

        await tester.pumpApp(bloc: signInBloc);
        await tester.pump();
        await tester.tap(
          find.byKey(const Key('signinForm_submition_elevatedButton')),
        );
        await tester.pump();

        verify(() => signInBloc.add(const SignInSubmitted())).called(1);
      },
    );
  });

  group('Sign in form submission failure', () {
    late MockSignInBloc signInBloc;

    setUp(() {
      signInBloc = MockSignInBloc();
      when(() => signInBloc.state).thenReturn(const SignInState());
    });

    testWidgets(
      '''
      Shows a snackbar with an 'unexpected' error message
      when submission throws a SignInFailure.
      ''',
      (tester) async {
        whenListen(
          signInBloc,
          Stream<SignInState>.fromIterable([
            const SignInState(
              status: FormzStatus.submissionFailure,
              error: SignInFailure(),
            ),
          ]),
        );

        await tester.pumpApp(bloc: signInBloc);
        await tester.pump();
        await tester.pump(const Duration(seconds: 3));

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('unexpected'), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows a snackbar with an 'incorrect' error message
      when submission throws a IncorrectPasswordFailure.
      ''',
      (tester) async {
        whenListen(
          signInBloc,
          Stream<SignInState>.fromIterable([
            SignInState(
              status: FormzStatus.submissionFailure,
              error: IncorrectPasswordFailure(),
            ),
          ]),
        );

        await tester.pumpApp(bloc: signInBloc);
        await tester.pump();
        await tester.pump(const Duration(seconds: 3));

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('incorrect'), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows a snackbar with an 'does not exist' error message
      when submission throws a UserDoesNotExistFailure.
      ''',
      (tester) async {
        whenListen(
          signInBloc,
          Stream<SignInState>.fromIterable([
            SignInState(
              status: FormzStatus.submissionFailure,
              error: UserDoesNotExistFailure(),
            ),
          ]),
        );

        await tester.pumpApp(bloc: signInBloc);
        await tester.pump();
        await tester.pump(const Duration(seconds: 3));

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('does not exist'), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows a snackbar with an 'locked' error message
      when submission throws a UserLockedFailure.
      ''',
      (tester) async {
        whenListen(
          signInBloc,
          Stream<SignInState>.fromIterable([
            SignInState(
              status: FormzStatus.submissionFailure,
              error: UserLockedFailure(),
            ),
          ]),
        );

        await tester.pumpApp(bloc: signInBloc);
        await tester.pump();
        await tester.pump(const Duration(seconds: 3));

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.textContaining('locked'), findsOneWidget);
      },
    );
  });
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required SignInBloc bloc,
  }) {
    return pumpWidget(
      BlocProvider<SignInBloc>.value(
        value: bloc,
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: SignInForm()),
        ),
      ),
    );
  }
}
