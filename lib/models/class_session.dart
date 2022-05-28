import 'package:equatable/equatable.dart';
import 'package:univalle_app/models/course.dart';

class ClassSession extends Equatable {
  const ClassSession({
    required this.course,
    required this.classroom,
    required this.startTime,
    required this.endTime,
  });

  /// Creates an empty class session.
  factory ClassSession.empty() {
    return ClassSession(
      course: const Course(),
      classroom: '',
      startTime: DateTime(0),
      endTime: DateTime(0),
    );
  }

  /// Creates a Course instance from a json object.
  factory ClassSession.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return ClassSession(
      course: const Course(),
      classroom: parsedJson['classroom'] as String,
      startTime: _getDateFromString(parsedJson['start'] as String),
      endTime: _getDateFromString(parsedJson['end'] as String),
    );
  }

  /// Converts a String in format [HH:MM] to a DateTime object.
  static DateTime _getDateFromString(String date) {
    final dateArr = date.split(':').map(int.parse).toList();
    return DateTime(0, 0, 0, dateArr[0], dateArr[1]);
  }

  bool get isEmpty => this == ClassSession.empty();

  ClassSession copyWith({
    Course? course,
    String? classroom,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return ClassSession(
      course: course ?? this.course,
      classroom: classroom ?? this.classroom,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  final Course course;
  final String classroom;
  final DateTime startTime;
  final DateTime endTime;

  @override
  List<Object?> get props => [
        course,
        classroom,
        startTime,
        endTime,
      ];
}
