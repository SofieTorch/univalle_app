part of 'students_bloc.dart';

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object> get props => [];
}

class StudentsRequested extends StudentsEvent {}
