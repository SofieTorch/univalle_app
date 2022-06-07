part of 'loan_list_bloc.dart';

abstract class LoanListEvent extends Equatable {
  const LoanListEvent();
}

class LoanListRequested extends LoanListEvent {
  @override
  List<Object> get props => [];
}
