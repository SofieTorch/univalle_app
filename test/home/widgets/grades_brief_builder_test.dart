import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/grades/grades.dart';
import 'package:univalle_app/home/widgets/widgets.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/theme/app_theme.dart';

class MockGradeListBloc extends MockBloc<GradeListEvent, GradeListState>
    implements GradeListBloc {}

void main() {
  group('GradesBriefBuilder', () {
    late MockGradeListBloc gradeListBloc;
    late Map<String, List<CourseGrade>> grades;

    setUp(() {
      gradeListBloc = MockGradeListBloc();
      when(() => gradeListBloc.state).thenReturn(const GradeListState());

      grades = {
        '1-2022': [
          const CourseGrade(
            course: Course(subject: 'Subject test 1'),
            finalExam: 100,
            partials: [100.0, 80.0],
            semestralGrade: 93,
          ),
          const CourseGrade(
            course: Course(subject: 'Subject test 2'),
            finalExam: 100,
            partials: [100.0, 100.0],
            semestralGrade: 100,
          ),
        ],
        '2-2021': [
          const CourseGrade(
            course: Course(subject: 'Subject test 3'),
            finalExam: 100,
            partials: [100.0, 100.0],
            semestralGrade: 100,
          ),
        ],
      };
    });

    testWidgets(
      '''
      description
      ''',
      (tester) async {
        whenListen(
          gradeListBloc,
          Stream<GradeListState>.fromIterable([
            GradeListState(
              status: GradeListRequestStatus.success,
              grades: grades,
              selectedManagement: '1-2022',
            ),
          ]),
        );

        await tester.pumpApp(bloc: gradeListBloc);
        await tester.pump();

        expect(
          find.byType(SemestralGradeCard),
          findsNWidgets(2),
        );

        expect(
          find.descendant(
            of: find.byType(ListView),
            matching: find.byWidgetPredicate(
              (widget) => widget is SizedBox && widget.width == 16,
            ),
          ),
          findsNWidgets(1),
        );
      },
    );
  });
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required GradeListBloc bloc,
  }) {
    return pumpWidget(
      BlocProvider<GradeListBloc>.value(
        value: bloc,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.light,
          home: const Scaffold(
            body: GradesBriefBuilder(),
          ),
        ),
      ),
    );
  }
}
