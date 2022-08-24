part of 'payments_fees_bloc.dart';

enum PaymentsRequestStatus { initial, loading, success, failure }

class PaymentsFeesState extends Equatable {
  const PaymentsFeesState({
    this.status = PaymentsRequestStatus.initial,
    this.fees = const [],
    this.errorMessage = '',
  });

  final PaymentsRequestStatus status;
  final List<Fees> fees;
  final String errorMessage;

  PaymentsFeesState copyWith({
    PaymentsRequestStatus? status,
    List<Fees>? fees,
    String? errorMessage,
  }) {
    return PaymentsFeesState(
      status: status ?? this.status,
      fees: fees ?? this.fees,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, fees, errorMessage];
}
