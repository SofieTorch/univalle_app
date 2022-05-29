part of 'grade_list_bloc.dart';

abstract class GradeListEvent extends Equatable {
  const GradeListEvent();
}

class GradeListRequested extends GradeListEvent {
  const GradeListRequested();

  @override
  List<Object> get props => [];
}

class ManagementChanged extends GradeListEvent {
  const ManagementChanged(this.managementSelected);
  final String managementSelected;

  @override
  List<Object?> get props => [managementSelected];
}
