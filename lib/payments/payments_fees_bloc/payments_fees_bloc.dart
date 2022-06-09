import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/payments_fees_repository.dart';
import 'package:univalle_app/models/models.dart';

part 'payments_fees_event.dart';
part 'payments_fees_state.dart';

class PaymentsFeesBloc extends Bloc<PaymentsFeesEvent, PaymentsFeesState> {
  PaymentsFeesBloc({
    required PaymentsFeesRepository paymentsFeesRepository,
  })  : _repository = paymentsFeesRepository,
        super(const PaymentsFeesState()) {
    on<PaymentsFeesRequested>(_onPaymentsRequested);
  }
  final PaymentsFeesRepository _repository;

  Future<void> _onPaymentsRequested(
    PaymentsFeesRequested event,
    Emitter<PaymentsFeesState> emit,
  ) async {
    emit(state.copyWith(status: PaymentsRequestStatus.loading));

    try {
      final fees = await _repository.getFees();
      emit(
        state.copyWith(
          status: PaymentsRequestStatus.success,
          fees: fees,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentsRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
