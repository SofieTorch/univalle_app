import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    this.id = 0,
    this.subject = '',
    this.group = '',
    this.teacher = '',
    this.management = '',
  });

  factory Course.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return Course(
      id: parsedJson['id'] as int,
      subject: parsedJson['name'] as String,
      group: parsedJson['group'] as String,
      teacher: parsedJson['teacher'] as String,
      management: parsedJson['management'] as String,
    );
  }

  final int id;
  final String subject;
  final String group;
  final String teacher;
  final String management;

  @override
  List<Object?> get props => [id, subject, group, teacher, management];
}
