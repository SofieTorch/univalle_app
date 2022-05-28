import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/schedule/schedule.dart';

void main() {
  testWidgets('Next Class Card renders correctly', (tester) async {
    final classSession = ClassSession(
      course: const Course(
        group: 'A',
        teacher: 'Teacher test',
        subject: 'Subject test',
      ),
      classroom: 'T206',
      startTime: DateTime(0, 0, 0, 8, 35),
      endTime: DateTime(0, 0, 0, 9, 25),
    );
    await tester.pumpApp(classSession: classSession);

    expect(find.byType(NextClassCard), findsOneWidget);
    expect(find.text('Subject test'), findsOneWidget);
    expect(find.text('Teacher test'), findsOneWidget);
  });
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({required ClassSession classSession}) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: NextClassCard(classSession),
          ),
        ),
      ),
    );
  }
}
