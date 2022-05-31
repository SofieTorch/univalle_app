import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/schedule/schedule.dart';

class MockScheduleBloc extends MockBloc<ScheduleEvent, ScheduleState>
    implements ScheduleBloc {}

void main() {
  group('Schedule View', () {
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
      Shows an error message
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

        expect(find.text('Error message test'), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows schedule tabs
      when state.status is ScheduleRequestStatus.success.
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

        expect(find.byType(TabBar), findsOneWidget);
        expect(find.byType(Tab), findsNWidgets(6));
        expect(find.text('Without classes for today :)'), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows schedule tabs and class session list
      when state.status is ScheduleRequestStatus.success
      and day selected has classes.
      ''',
      (tester) async {
        whenListen(
          scheduleBloc,
          Stream<ScheduleState>.fromIterable([
            ScheduleState(
              status: ScheduleRequestStatus.success,
              schedule: Schedule(
                <int, List<ClassSession>>{
                  1: [
                    ClassSession(
                      classroom: 'T206',
                      startTime: DateTime(0, 0, 0, 08, 35),
                      endTime: DateTime(0, 0, 0, 09, 25),
                      course: const Course(
                        subject: 'Redes y comunicacion de datos',
                        group: 'A',
                        teacher: 'Joaquin Justiniano',
                      ),
                    ),
                    ClassSession(
                      classroom: 'T206',
                      startTime: DateTime(0, 0, 0, 09, 25),
                      endTime: DateTime(0, 0, 0, 10, 15),
                      course: const Course(
                        subject: 'Redes y comunicacion de datos',
                        group: 'A',
                        teacher: 'Joaquin Justiniano',
                      ),
                    ),
                  ]
                },
              ),
            ),
          ]),
        );

        await tester.pumpApp(bloc: scheduleBloc);
        await tester.pump();

        expect(find.byType(TabBar), findsOneWidget);
        expect(find.byType(Tab), findsNWidgets(6));
        expect(find.byType(DayScheduleList), findsOneWidget);
        expect(find.byType(ScheduleClassItem), findsNWidgets(2));
        expect(find.byType(Divider), findsOneWidget);
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
          home: Scaffold(body: ScheduleView()),
        ),
      ),
    );
  }
}
