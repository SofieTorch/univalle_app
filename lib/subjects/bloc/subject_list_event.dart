part of 'subject_list_bloc.dart';

abstract class SubjectListEvent extends Equatable {
  const SubjectListEvent();

  @override
  List<Object> get props => [];
}

class SubjectListRequested extends SubjectListEvent {}
