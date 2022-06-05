part of 'payment_places_bloc.dart';

abstract class PaymentPlacesState extends Equatable {
  const PaymentPlacesState();
  
  @override
  List<Object> get props => [];
}

class PaymentPlacesInitial extends PaymentPlacesState {}
