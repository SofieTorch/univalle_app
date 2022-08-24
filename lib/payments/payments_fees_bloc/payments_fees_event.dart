part of 'payments_fees_bloc.dart';

abstract class PaymentsFeesEvent extends Equatable {
  const PaymentsFeesEvent();
}

class PaymentsFeesRequested extends PaymentsFeesEvent {
  @override
  List<Object> get props => [];
}
