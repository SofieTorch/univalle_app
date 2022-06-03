part of 'loan_list_bloc.dart';

enum LoanListRequestStatus { initial, loading, success, failure }

class LoanListState extends Equatable {
  const LoanListState({
    this.status = LoanListRequestStatus.initial,
    this.loans = const [],
    this.errorMessage = '',
  });

  final LoanListRequestStatus status;
  final List<Loan> loans;
  final String errorMessage;

  LoanListState copyWith({
    LoanListRequestStatus? status,
    List<Loan>? loans,
    String? errorMessage,
  }) {
    return LoanListState(
      status: status ?? this.status,
      loans: loans ?? this.loans,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, loans, errorMessage];
}
