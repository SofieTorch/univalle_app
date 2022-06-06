part of 'payment_places_bloc.dart';

enum PaymentListRequestStatus { initial, loading, success, failure }

class PaymentPlacesState extends Equatable {
  const PaymentPlacesState({
    this.status = PaymentListRequestStatus.initial,
    this.paymentplaces = const <PaymentsPlaces>[],
    this.errorMessage = '',
  });

  final PaymentListRequestStatus status;
  final List<PaymentsPlaces> paymentplaces;
  final String errorMessage;

  PaymentPlacesState copyWith({
    PaymentListRequestStatus? status,
    List<PaymentsPlaces>? paymentplaces,
    String? errorMessage,
  }) {
    return PaymentPlacesState(
      status: status ?? this.status,
      paymentplaces: paymentplaces ?? this.paymentplaces,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, paymentplaces, errorMessage];
}
