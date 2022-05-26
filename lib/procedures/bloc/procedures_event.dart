part of 'procedures_bloc.dart';

abstract class ProceduresEvent extends Equatable {
  const ProceduresEvent();

  @override
  List<Object> get props => [];
}

class ProcedureListRequested extends ProceduresEvent {}
