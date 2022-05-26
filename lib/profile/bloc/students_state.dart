part of 'students_bloc.dart';

enum StudentRequestStatus { initial, loading, success, failure }

class StudentsState extends Equatable {
  const StudentsState({
    this.status = StudentRequestStatus.initial,
    this.student = const Student(),
    this.errorMessage,
  });

  final StudentRequestStatus status;
  final Student student;
  final String? errorMessage;

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
  List<Object> get props => [status, student];
}
