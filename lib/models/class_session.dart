import 'package:equatable/equatable.dart';
import 'package:univalle_app/models/course.dart';

class ClassSession extends Equatable {
  ClassSession({
    this.course = const Course(),
    this.classroom = '',
    DateTime? startTime,
    DateTime? endTime,
  }) {
    this.startTime = startTime ?? DateTime.now();
    this.endTime = endTime ?? DateTime.now();
  }

  /// Creates a Course instance from a json object.
  factory ClassSession.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return ClassSession(
      classroom: parsedJson['classroom'] as String,
      startTime: _getDateFromString(parsedJson['start'] as String),
      endTime: _getDateFromString(parsedJson['end'] as String),
    );
  }

  static DateTime _getDateFromString(String date) {
    final dateArr = date.split(':').map(int.parse).toList();
    return DateTime(0, 0, 0, dateArr[0], dateArr[1]);
  }

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
  late final DateTime startTime;
  late final DateTime endTime;

  @override
  List<Object?> get props => [
        course,
        classroom,
        startTime,
        endTime,
      ];
}
