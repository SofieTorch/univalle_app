import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/discounts_repository.dart';
import 'package:univalle_app/models/models.dart';

part 'discount_list_event.dart';
part 'discount_list_state.dart';

class DiscountListBloc extends Bloc<DiscountListEvent, DiscountListState> {
  DiscountListBloc({
    required DiscountsRepository discountsRepository,
  })  : _repository = discountsRepository,
        super(const DiscountListState()) {
    on<DiscountListRequested>(_onDiscountListRequested);
  }

  final DiscountsRepository _repository;

  Future<void> _onDiscountListRequested(
    DiscountListRequested event,
    Emitter<DiscountListState> emit,
  ) async {
    emit(state.copyWith(status: DiscountListRequestStatus.loading));
    try {
      final discounts = await _repository.getDiscounts();
      emit(
        state.copyWith(
          status: DiscountListRequestStatus.success,
          discounts: discounts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DiscountListRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
