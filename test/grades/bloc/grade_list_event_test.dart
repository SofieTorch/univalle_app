import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/grades/grades.dart';

void main() {
  group('GradeListEvent', () {
    test('GradeListRequested props are empty', () {
      const event = GradeListRequested();
      expect(event.props, isEmpty);
    });

    test('ManagementChanged props are empty', () {
      const event = ManagementChanged('test');
      expect(event.props, contains('test'));
    });
  });
}
