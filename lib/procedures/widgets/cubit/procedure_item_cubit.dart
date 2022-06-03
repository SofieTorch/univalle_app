import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/models/procedure.dart';

part 'procedure_item_state.dart';

class ProcedureItemCubit extends Cubit<ProcedureItemState> {
  ProcedureItemCubit(Procedure procedure)
      : super(ProcedureItemState(procedure: procedure));

  void changeRequirementsVisibility() {
    emit(state.copyWith(showRequirements: !state.showRequirements));
  }
}
