part of 'payment_item_cubit.dart';

class PaymentItemState extends Equatable {
  const PaymentItemState({
    this.showPayments = true,
  });

  final bool showPayments;

  PaymentItemState copyWith({
    required bool showPayments,
  }) {
    return PaymentItemState(
      showPayments: showPayments,
    );
  }

  @override
  List<Object> get props => [showPayments];
}
