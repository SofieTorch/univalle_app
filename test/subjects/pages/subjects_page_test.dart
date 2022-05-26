import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/academic/widgets/no_enrolled_message.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/course.dart';
import 'package:univalle_app/subjects/subjects.dart';

class MockSubjectListBloc extends MockBloc<SubjectListEvent, SubjectListState>
    implements SubjectListBloc {}

void main() {
  group('Subjects View', () {
    late MockSubjectListBloc subjectListBloc;

    setUp(() {
      subjectListBloc = MockSubjectListBloc();
      when(() => subjectListBloc.state).thenReturn(const SubjectListState());
    });

    testWidgets(
      '''
      Shows a CircularProgressIndicator
      when state.status is SubjectListRequestStatus.loading.
      ''',
      (tester) async {
        whenListen(
          subjectListBloc,
          Stream<SubjectListState>.fromIterable([
            const SubjectListState(
              status: SubjectListRequestStatus.loading,
            ),
          ]),
        );

        await tester.pumpApp(bloc: subjectListBloc);
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows an error message
      when state.status is SubjectListRequestStatus.failure.
      ''',
      (tester) async {
        whenListen(
          subjectListBloc,
          Stream<SubjectListState>.fromIterable([
            const SubjectListState(
              status: SubjectListRequestStatus.failure,
              errorMessage: 'Error message test',
            ),
          ]),
        );

        await tester.pumpApp(bloc: subjectListBloc);
        await tester.pump();

        expect(find.text('Error message test'), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows NoEnrolledMessage when state.status
      is SubjectListRequestStatus.success but courses are empty.
      ''',
      (tester) async {
        whenListen(
          subjectListBloc,
          Stream<SubjectListState>.fromIterable([
            const SubjectListState(
              status: SubjectListRequestStatus.success,
            ),
          ]),
        );

        await tester.pumpApp(bloc: subjectListBloc);
        await tester.pump();

        expect(find.byType(NoEnrolledMessage), findsOneWidget);
      },
    );

    testWidgets(
      '''
      Shows subject list when state.status is
      SubjectListRequestStatus.success and courses are not empty.
      ''',
      (tester) async {
        whenListen(
          subjectListBloc,
          Stream<SubjectListState>.fromIterable([
            const SubjectListState(
              status: SubjectListRequestStatus.success,
              courses: [
                Course(
                  subject: 'subject test 1',
                  group: 'A',
                  teacher: 'teacher test 1',
                ),
                Course(
                  subject: 'subject test 2',
                  group: 'B',
                  teacher: 'teacher test 2',
                ),
              ],
            ),
          ]),
        );

        await tester.pumpApp(bloc: subjectListBloc);
        await tester.pump();

        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(SubjectListItem), findsNWidgets(2));
      },
    );
  });
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required SubjectListBloc bloc,
  }) {
    return pumpWidget(
      BlocProvider<SubjectListBloc>.value(
        value: bloc,
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: SubjectsView()),
        ),
      ),
    );
  }
}
