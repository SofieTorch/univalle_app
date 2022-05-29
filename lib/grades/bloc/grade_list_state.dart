part of 'grade_list_bloc.dart';

enum GradeListRequestStatus { initial, loading, success, failure }

class GradeListState extends Equatable {
  const GradeListState({
    this.status = GradeListRequestStatus.initial,
    this.grades = const {},
    this.errorMessage = '',
    this.selectedManagement = '',
  });

  final GradeListRequestStatus status;
  final Map<String, List<CourseGrade>> grades;
  final String errorMessage;
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
