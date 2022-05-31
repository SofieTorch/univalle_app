import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/grades/grades.dart';
import 'package:univalle_app/home/home.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/schedule/schedule.dart';

class MockScheduleBloc extends MockBloc<ScheduleEvent, ScheduleState>
    implements ScheduleBloc {}

class MockGradeListBloc extends MockBloc<GradeListEvent, GradeListState>
    implements GradeListBloc {}

void main() {
  group('Home View: Next class', () {
    late MockScheduleBloc scheduleBloc;
    late MockGradeListBloc gradeListBloc;

    setUp(() {
      scheduleBloc = MockScheduleBloc();
      gradeListBloc = MockGradeListBloc();
      when(() => scheduleBloc.state).thenReturn(const ScheduleState());
      when(() => gradeListBloc.state).thenReturn(const GradeListState());
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

        await tester.pumpApp(
          scheduleBloc: scheduleBloc,
          gradeListBloc: gradeListBloc,
        );
        await tester.pump();

        expect(
          find.descendant(
            of: find.byType(NextClassBuilder),
            matching: find.byType(CircularProgressIndicator),
          ),
          findsOneWidget,
        );
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

        await tester.pumpApp(
          scheduleBloc: scheduleBloc,
          gradeListBloc: gradeListBloc,
        );
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

        await tester.pumpApp(
          scheduleBloc: scheduleBloc,
          gradeListBloc: gradeListBloc,
        );
        await tester.pump();

        expect(find.byType(AlertMessage), findsOneWidget);
        expect(find.textContaining('No more classes'), findsOneWidget);
      },
    );
  });
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required ScheduleBloc scheduleBloc,
    required GradeListBloc gradeListBloc,
  }) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ScheduleBloc>.value(
            value: scheduleBloc,
          ),
          BlocProvider<GradeListBloc>.value(
            value: gradeListBloc,
          ),
        ],
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
