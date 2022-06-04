import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univalle_app/academic/academic.dart';
import 'package:univalle_app/app/app.dart';
import 'package:univalle_app/app/widgets/widgets.dart';
import 'package:univalle_app/discounts/discounts.dart';
import 'package:univalle_app/home/home.dart';
import 'package:univalle_app/library/library.dart';
import 'package:univalle_app/library_loans/library_loans.dart';
import 'package:univalle_app/procedures/procedures.dart';
import 'package:univalle_app/profile/pages/profile_page.dart';
import 'package:univalle_app/sign_in/sign_in.dart';
import 'package:univalle_app/splash/splash.dart';

void main() {
  group('Authentication workflow', () {
    testWidgets('renders Splash screen at first', (tester) async {
      await tester.pumpWidget(App());
      await tester.pump();
      expect(find.byType(SplashView), findsOneWidget);
    });

    testWidgets(
      '''
        renders Sign in page when shared preferences
        sign in values does not exists.
        ''',
      (tester) async {
        final app = App();
        SharedPreferences.setMockInitialValues({});
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        expect(find.byType(SignInPage), findsOneWidget);
      },
    );

    testWidgets(
      '''
        renders Home page when shared preferences
        sign in values exists.
        ''',
      (tester) async {
        final app = App();
        SharedPreferences.setMockInitialValues({
          'code': 'TCS0028814',
          'token': 'TCS0028814:144963',
        });
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      },
    );
  });

  group('Bottom navigation bar navigation', () {
    testWidgets('renders and navigates to Academic page', (tester) async {
      final app = App();
      SharedPreferences.setMockInitialValues({
        'code': 'TCS0028814',
        'token': 'TCS0028814:144963',
      });
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.byIcon(MdiIcons.school),
        ),
      );

      await tester.pump();
      final bottomNavbar = tester.firstWidget(find.byType(BottomNavigationBar))
          as BottomNavigationBar;

      expect(bottomNavbar.currentIndex, 1);
      expect(find.byType(AcademicPage), findsOneWidget);
    });

    testWidgets('renders and navigates to Payments page', (tester) async {
      final app = App();
      SharedPreferences.setMockInitialValues({
        'code': 'TCS0028814',
        'token': 'TCS0028814:144963',
      });
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.byIcon(MdiIcons.cashMultiple),
        ),
      );

      await tester.pump();

      final bottomNavbar = tester.firstWidget(find.byType(BottomNavigationBar))
          as BottomNavigationBar;

      expect(bottomNavbar.currentIndex, 2);
      // to do: when academic page exists, replace the HomePage
      // in the line above with PaymentsPage
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('renders and navigates to Profile page', (tester) async {
      final app = App();
      SharedPreferences.setMockInitialValues({
        'code': 'TCS0028814',
        'token': 'TCS0028814:144963',
      });
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.byIcon(MdiIcons.accountCircle),
        ),
      );

      await tester.pump();

      final bottomNavbar = tester.firstWidget(find.byType(BottomNavigationBar))
          as BottomNavigationBar;

      expect(bottomNavbar.currentIndex, 3);
      expect(find.byType(ProfilePage), findsOneWidget);
    });
  });

  group('Bottom sheet menu navigation', () {
    testWidgets(
      'opens bottom sheet menu when clicking on its icon',
      (WidgetTester tester) async {
        final app = App();
        SharedPreferences.setMockInitialValues({
          'code': 'TCS0028814',
          'token': 'TCS0028814:144963',
        });
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        expect(find.byIcon(MdiIcons.menu), findsOneWidget);

        await tester.tap(find.byIcon(MdiIcons.menu));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheetMenu), findsOneWidget);
      },
    );

    testWidgets(
      'launch Procedure Types page when clicking on its element inside menu',
      (WidgetTester tester) async {
        final app = App();
        SharedPreferences.setMockInitialValues({
          'code': 'TCS0028814',
          'token': 'TCS0028814:144963',
        });
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(MdiIcons.menu));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(MdiIcons.clipboardTextClockOutline));
        await tester.pumpAndSettle();

        expect(find.byType(ProceduresPage), findsOneWidget);
        expect(find.byType(BottomSheetMenu), findsNothing);
      },
    );

    testWidgets(
      'launch Discounts page when clicking on its element inside menu',
      (WidgetTester tester) async {
        final app = App();
        SharedPreferences.setMockInitialValues({
          'code': 'TCS0028814',
          'token': 'TCS0028814:144963',
        });
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(MdiIcons.menu));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(MdiIcons.ticketPercentOutline));
        await tester.pumpAndSettle();

        expect(find.byType(DiscountsPage), findsOneWidget);
        expect(find.byType(BottomSheetMenu), findsNothing);
      },
    );

    testWidgets(
      'launch Library page when clicking on its element inside menu',
      (WidgetTester tester) async {
        final app = App();
        SharedPreferences.setMockInitialValues({
          'code': 'TCS0028814',
          'token': 'TCS0028814:144963',
        });
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(MdiIcons.menu));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(MdiIcons.bookEducationOutline));
        await tester.pumpAndSettle();

        expect(find.byType(LibraryPage), findsOneWidget);
        expect(find.byType(BottomSheetMenu), findsNothing);
      },
    );

    testWidgets(
      '''
      launches LibraryLoans page when clicking "Outstanding loans" button
      after navigating to Library page
      ''',
      (WidgetTester tester) async {
        final app = App();
        SharedPreferences.setMockInitialValues({
          'code': 'TCS0028814',
          'token': 'TCS0028814:144963',
        });
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(MdiIcons.menu));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(MdiIcons.bookEducationOutline));
        await tester.pumpAndSettle();
        await tester.tap(
          find.descendant(
            of: find.byType(TextButton),
            matching: find.text('OUTSTANDING LOANS'),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(LibraryLoansPage), findsOneWidget);
      },
    );
  });
}
