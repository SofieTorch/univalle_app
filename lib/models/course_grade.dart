import 'package:equatable/equatable.dart';
import 'package:univalle_app/models/course.dart';

class CourseGrade extends Equatable {
  const CourseGrade({
    required this.course,
    this.partials = const [],
    this.finalExam = 0,
    this.semestralGrade = 0,
  });

  /// Creates a CourseGrade instance from a json object.
  factory CourseGrade.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return CourseGrade(
      course: const Course(),
      finalExam: parsedJson['final'] as double,
      partials: (parsedJson['partials'] as List<dynamic>)
          .map((dynamic e) => e as double)
          .toList(),
      semestralGrade: parsedJson['semestral'] as double,
    );
  }

  final Course course;
  final List<double> partials;
  final double finalExam;
  final double semestralGrade;

  /// Evaluates if [course] is approved. It is considerated
  /// approved if [semestralGrade] is more than 50.
  bool get isApproved => semestralGrade > 50;

  /// Percentage of the semester grade worth each midterm.
  double get midtermsWeight {
    if (partials.length == 4) return 0.2;
    if (partials.length == 2) return 0.35;
    return 0;
  }

  /// Percentage of the semester grade worth the final exam.
  double get finalWeight {
    if (partials.length == 4) return 0.2;
    if (partials.length == 2) return 0.3;
    return 1;
  }

  CourseGrade copyWith({
    Course? course,
    List<double>? partials,
    double? finalExam,
    double? semestralGrade,
  }) {
    return CourseGrade(
      course: course ?? this.course,
      partials: partials ?? this.partials,
      finalExam: finalExam ?? this.finalExam,
      semestralGrade: semestralGrade ?? this.semestralGrade,
    );
  }

  @override
  List<Object?> get props => [course, partials, finalExam, semestralGrade];
}
