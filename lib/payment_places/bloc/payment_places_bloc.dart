import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/payment_places_repository.dart';
import 'package:univalle_app/models/payment_places.dart';

part 'payment_places_event.dart';
part 'payment_places_state.dart';

class PaymentPlacesBloc extends Bloc<PaymentPlacesEvent, PaymentPlacesState> {
  PaymentPlacesBloc({required PaymentPlacesRepository paymentRepository})
      : _repository = paymentRepository,
        super(const PaymentPlacesState()) {
    on<PaymentListRequested>(_onPaymentsRequested);
  }

  final PaymentPlacesRepository _repository;

  Future<void> _onPaymentsRequested(
    PaymentListRequested event,
    Emitter<PaymentPlacesState> emit,
  ) async {
    emit(state.copyWith(status: PaymentListRequestStatus.loading));
    try {
      final payment = await _repository.getPaymentPlaces();
      emit(
        state.copyWith(
          status: PaymentListRequestStatus.success,
          paymentplaces: payment,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentListRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
