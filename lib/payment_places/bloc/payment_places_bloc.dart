import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_places_event.dart';
part 'payment_places_state.dart';

class PaymentPlacesBloc extends Bloc<PaymentPlacesEvent, PaymentPlacesState> {
  PaymentPlacesBloc() : super(PaymentPlacesInitial()) {}
}
