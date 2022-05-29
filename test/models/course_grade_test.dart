import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/models/models.dart';

void main() {
  group('CourseGrade model', () {
    late CourseGrade courseGrade;

    setUp(() {
      courseGrade = const CourseGrade(
        course: Course(subject: 'Course subject test'),
        finalExam: 93,
        partials: [100.0, 80.0],
        semestralGrade: 93,
      );
    });

    test('Evaluates .isApproved correctly', () {
      expect(courseGrade.isApproved, equals(true));
    });

    test('.copyWith() without course returns the current course', () {
      final copy = courseGrade.copyWith();
      expect(copy, equals(courseGrade));
    });
  });

  group('CourseGrade weights', () {
    late CourseGrade courseGrade;

    setUp(() {
      courseGrade = const CourseGrade(
        course: Course(subject: 'Course subject test'),
        finalExam: 93,
        partials: [100.0, 80.0],
        semestralGrade: 93,
      );
    });

    test('Evaluates .midtermsWeight for 2 midterms as 0.35', () {
      expect(courseGrade.midtermsWeight, 0.35);
    });

    test('Evaluates .midtermsWeight for 4 midterms as 0.2', () {
      final courseGrade4Midterms = courseGrade.copyWith(
        partials: [100.0, 100.0, 80.0, 80.0],
      );
      expect(courseGrade4Midterms.midtermsWeight, 0.2);
    });

    test('Evaluates .midtermsWeight for 0 midterms as 0', () {
      final courseGrade0Midterms = courseGrade.copyWith(
        partials: [],
      );
      expect(courseGrade0Midterms.midtermsWeight, 0);
    });

    test('Evaluates .finalWeight for 2 midterms as 0.3', () {
      expect(courseGrade.finalWeight, 0.3);
    });

    test('Evaluates .finalWeight for 4 midterms as 0.2', () {
      final courseGrade4Midterms = courseGrade.copyWith(
        partials: [100.0, 100.0, 80.0, 80.0],
      );
      expect(courseGrade4Midterms.finalWeight, 0.2);
    });

    test('Evaluates .finalWeight for 0 midterms as 1', () {
      final courseGrade0Midterms = courseGrade.copyWith(
        partials: [],
      );
      expect(courseGrade0Midterms.finalWeight, 1);
    });
  });
}
