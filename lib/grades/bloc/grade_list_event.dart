part of 'grade_list_bloc.dart';

abstract class GradeListEvent extends Equatable {
  const GradeListEvent();
}

class GradeListRequested extends GradeListEvent {
  const GradeListRequested();

  @override
  List<Object> get props => [];
}
