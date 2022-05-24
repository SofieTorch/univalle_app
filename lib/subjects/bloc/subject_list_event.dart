part of 'subject_list_bloc.dart';

abstract class SubjectListEvent extends Equatable {
  const SubjectListEvent();
}

class SubjectListRequested extends SubjectListEvent {
  @override
  List<Object> get props => [];
}
