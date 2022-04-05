import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/app/app.dart';
import 'package:univalle_app/home/home.dart';

void main() {
  group('App', () {
    testWidgets('renders Home', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
