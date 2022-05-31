part of 'grade_list_bloc.dart';

/// Base class for [GradeListBloc] events.
abstract class GradeListEvent extends Equatable {
  const GradeListEvent();
}

/// Triggered when grades have been requested.
class GradeListRequested extends GradeListEvent {
  const GradeListRequested();

  @override
  List<Object> get props => [];
}

/// Triggered when the selected management has changed
/// to update the current selected grade list (that is shown to user).
class ManagementChanged extends GradeListEvent {
  const ManagementChanged(this.managementSelected);
  final String managementSelected;

  @override
  List<Object?> get props => [managementSelected];
}
