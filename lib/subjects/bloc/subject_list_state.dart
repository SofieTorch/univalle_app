part of 'subject_list_bloc.dart';

enum SubjectListRequestStatus { initial, loading, success, failure }

class SubjectListState extends Equatable {
  const SubjectListState({
    this.status = SubjectListRequestStatus.initial,
    this.courses = const <Course>[],
    this.errorMessage,
  });

  final SubjectListRequestStatus status;
  final List<Course> courses;
  final String? errorMessage;

  SubjectListState copyWith({
    SubjectListRequestStatus? status,
    List<Course>? courses,
    String? errorMessage,
  }) {
    return SubjectListState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, courses];
}
