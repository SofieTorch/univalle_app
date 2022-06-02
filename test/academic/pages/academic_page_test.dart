import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univalle_app/academic/academic.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/grades/grades.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/schedule/pages/schedule_page.dart';
import 'package:univalle_app/subjects/pages/subjects_page.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('Academic page navigation', () {
    testWidgets(
      'Renders Grades page at first',
      (tester) async {
        await tester.pumpApp();
        expect(find.byType(GradesPage), findsOneWidget);
        expect(find.byType(SchedulePage), findsNothing);
        expect(find.byType(SubjectsPage), findsNothing);
      },
    );

    testWidgets(
      'Navigates to and renders Schedule page correctly',
      (tester) async {
        await tester.pumpApp();
        await tester.tap(
          find.descendant(
            of: find.byType(TabBar),
            matching: find.text('SCHEDULE'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(GradesPage), findsNothing);
        expect(find.byType(SchedulePage), findsOneWidget);
        expect(find.byType(SubjectsPage), findsNothing);
      },
    );

    testWidgets(
      'Navigates to and renders SubjectsP page correctly',
      (tester) async {
        await tester.pumpApp();
        await tester.tap(
          find.descendant(
            of: find.byType(TabBar),
            matching: find.text('SUBJECTS'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(GradesPage), findsNothing);
        expect(find.byType(SchedulePage), findsNothing);
        expect(find.byType(SubjectsPage), findsOneWidget);
      },
    );
  });
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp() {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: RepositoryProvider(
          create: (context) => StorageProvider(prefs: MockSharedPreferences()),
          child: const Scaffold(body: AcademicPage()),
        ),
      ),
    );
  }
}
