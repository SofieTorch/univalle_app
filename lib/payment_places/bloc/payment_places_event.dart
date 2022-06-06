part of 'payment_places_bloc.dart';

abstract class PaymentPlacesEvent extends Equatable {
  const PaymentPlacesEvent();
}

class PaymentListRequested extends PaymentPlacesEvent {
  const PaymentListRequested();

  @override
  List<Object> get props => [];
}
