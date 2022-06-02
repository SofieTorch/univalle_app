part of 'students_bloc.dart';

enum StudentRequestStatus { initial, loading, success, failure }

class StudentsState extends Equatable {
  StudentsState({
    this.status = StudentRequestStatus.initial,
    Student? student,
    this.errorMessage = '',
  }) {
    this.student = student ?? Student();
  }

  final StudentRequestStatus status;
  late final Student student;
  final String errorMessage;

  StudentsState copyWith({
    StudentRequestStatus? status,
    Student? student,
    String? errorMessage,
  }) {
    return StudentsState(
      status: status ?? this.status,
      student: student ?? this.student,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, student, errorMessage];
}
