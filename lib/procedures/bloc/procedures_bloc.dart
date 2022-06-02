import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/procedures_repository.dart';
import 'package:univalle_app/models/procedure.dart';
part 'procedures_event.dart';
part 'procedures_state.dart';

class ProceduresBloc extends Bloc<ProceduresEvent, ProceduresState> {
  ProceduresBloc({required ProcedureRepository procedureRepository})
      : _repository = procedureRepository,
        super(const ProceduresState()) {
    on<ProcedureListRequested>(_onProceduresRequested);
  }

  final ProcedureRepository _repository;

  Future<void> _onProceduresRequested(
    ProcedureListRequested event,
    Emitter<ProceduresState> emit,
  ) async {
    emit(state.copyWith(status: ProcedureListRequestStatus.loading));
    try {
      final procedures = await _repository.getProcedure();
      emit(
        state.copyWith(
          status: ProcedureListRequestStatus.success,
          procedures: procedures,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProcedureListRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
