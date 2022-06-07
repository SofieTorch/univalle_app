import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/credit/widgets/cubit_credit/credit_item_state.dart';

class CreditItemCubit extends Cubit<CreditItemState> {
  CreditItemCubit() : super(const CreditItemState());

  void changeRequirementsVisibility() {
    emit(state.copyWith(showCredit: !state.showCredit));
  }
}
