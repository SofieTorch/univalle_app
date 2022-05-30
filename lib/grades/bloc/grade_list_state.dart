part of 'grade_list_bloc.dart';

/// Status for the http request made to retrieve grades.
enum GradeListRequestStatus { initial, loading, success, failure }

/// State of [GradeListBloc].
class GradeListState extends Equatable {
  const GradeListState({
    this.status = GradeListRequestStatus.initial,
    this.grades = const {},
    this.errorMessage = '',
    this.selectedManagement = '',
  });

  /// Http request status when retrieving grades.
  final GradeListRequestStatus status;

  /// Grades grouped by management.
  final Map<String, List<CourseGrade>> grades;

  /// Error message in case that [status] is failure,
  /// in other words, when the request to retrieve grades has failed.
  final String errorMessage;

  /// Key to select a grade list by management.
  final String selectedManagement;

  GradeListState copyWith({
    GradeListRequestStatus? status,
    Map<String, List<CourseGrade>>? grades,
    String? errorMessage,
    String? selectedManagement,
  }) {
    return GradeListState(
      status: status ?? this.status,
      grades: grades ?? this.grades,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedManagement: selectedManagement ?? this.selectedManagement,
    );
  }

  @override
  List<Object> get props => [status, grades, errorMessage, selectedManagement];
}
