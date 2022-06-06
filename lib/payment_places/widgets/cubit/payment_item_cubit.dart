import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_item_state.dart';

class PaymentItemCubit extends Cubit<PaymentItemState> {
  PaymentItemCubit() : super(const PaymentItemState());

  void changeRequirementsVisibility() {
    emit(state.copyWith(showPayments: !state.showPayments));
  }
}
