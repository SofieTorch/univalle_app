part of 'subject_list_bloc.dart';

/// Http request status when making the subject list request.
enum SubjectListRequestStatus { initial, loading, success, failure }

/// State emitted by [SubjectListBloc].
///
/// Contains the course/subject list and
/// its request status ([SubjectListRequestStatus]).
class SubjectListState extends Equatable {
  const SubjectListState({
    this.status = SubjectListRequestStatus.initial,
    this.courses = const <Course>[],
    this.errorMessage,
  });

  /// Status of the http request.
  final SubjectListRequestStatus status;

  /// Error message when the http request was unsuccessful
  /// or something unexpected happend.
  final String? errorMessage;

  final List<Course> courses;

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
