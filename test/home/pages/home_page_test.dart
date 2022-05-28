import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/home/home.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/schedule/schedule.dart';

class MockScheduleBloc extends MockBloc<ScheduleEvent, ScheduleState>
    implements ScheduleBloc {}

void main() {
  group('Home View: Next class', () {
    late MockScheduleBloc scheduleBloc;

    setUp(() {
      scheduleBloc = MockScheduleBloc();
      when(() => scheduleBloc.state).thenReturn(const ScheduleState());
    });

    testWidgets(
      '''
      Shows a CircularProgressIndicator
      when state.status is ScheduleRequestStatus.loading.
      ''',
      (tester) async {
        whenListen(
          scheduleBloc,
          Stream<ScheduleState>.fromIterable([
            const ScheduleState(
              status: ScheduleRequestStatus.loading,
            ),
          ]),
        );

        await tester.pumpApp(bloc: scheduleBloc);
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows an AlertMessage with an error message
      when state.status is ScheduleRequestStatus.failure.
      ''',
      (tester) async {
        whenListen(
          scheduleBloc,
          Stream<ScheduleState>.fromIterable([
            const ScheduleState(
              status: ScheduleRequestStatus.failure,
              errorMessage: 'Error message test',
            ),
          ]),
        );

        await tester.pumpApp(bloc: scheduleBloc);
        await tester.pump();

        expect(find.byType(AlertMessage), findsOneWidget);
        expect(find.textContaining('Error message test'), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows an AlertMessage informing there is no more classes
      when state.status is ScheduleRequestStatus.success
      and todays schedule has no classes.
      ''',
      (tester) async {
        whenListen(
          scheduleBloc,
          Stream<ScheduleState>.fromIterable([
            const ScheduleState(
              status: ScheduleRequestStatus.success,
            ),
          ]),
        );

        await tester.pumpApp(bloc: scheduleBloc);
        await tester.pump();

        expect(find.byType(AlertMessage), findsOneWidget);
        expect(find.textContaining('No more classes'), findsOneWidget);
      },
    );
  });
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required ScheduleBloc bloc,
  }) {
    return pumpWidget(
      BlocProvider<ScheduleBloc>.value(
        value: bloc,
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: HomeView()),
        ),
      ),
    );
  }
}
