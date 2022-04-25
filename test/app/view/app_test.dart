import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/app/app.dart';
import 'package:univalle_app/app/widgets/widgets.dart';
import 'package:univalle_app/home/home.dart';
import 'package:univalle_app/procedures/procedures.dart';

void main() {
  testWidgets('renders Home', (tester) async {
    final app = App();
    await tester.pumpWidget(app);
    // expect(find.byType(RootPage), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
  });

  group('Bottom navigation bar navigation', () {
    testWidgets('renders and navigates to Academic page', (tester) async {
      await tester.pumpWidget(App());
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
      // to do: when academic page exists, replace the HomePage
      // in the line above with AcademicPage
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('renders and navigates to Payments page', (tester) async {
      await tester.pumpWidget(App());
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
      await tester.pumpWidget(App());
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
      // to do: when academic page exists, replace the HomePage
      // in the line above with ProfilePage
      expect(find.byType(HomePage), findsOneWidget);
    });
  });

  group('Bottom sheet menu navigation', () {
    testWidgets(
      'opens bottom sheet menu when clicking on its icon',
      (WidgetTester tester) async {
        await tester.pumpWidget(App());
        expect(find.byIcon(MdiIcons.menu), findsOneWidget);

        await tester.tap(find.byIcon(MdiIcons.menu));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheetMenu), findsOneWidget);
      },
    );

    testWidgets(
      'launch Procedure Types page when clicking on its element inside menu',
      (WidgetTester tester) async {
        await tester.pumpWidget(App());
        await tester.tap(find.byIcon(MdiIcons.menu));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(MdiIcons.clipboardTextClockOutline));
        await tester.pumpAndSettle();

        expect(find.byType(ProceduresPage), findsOneWidget);
        expect(find.byType(BottomSheetMenu), findsNothing);
      },
    );
  });
}
