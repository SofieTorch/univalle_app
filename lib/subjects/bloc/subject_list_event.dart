part of 'subject_list_bloc.dart';

abstract class SubjectListEvent extends Equatable {
  const SubjectListEvent();
}

/// Triggered to request the subject list, at the start
/// of the SubjectsPage
class SubjectListRequested extends SubjectListEvent {
  @override
  List<Object> get props => [];
}
