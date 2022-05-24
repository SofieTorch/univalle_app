import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/procedures_repository.dart';

import '../../models/procedure.dart';

part 'procedures_event.dart';
part 'procedures_state.dart';

final ProcedureRepository repository;

class ProceduresBloc extends Bloc<ProceduresEvent, ProceduresState> {
  ProceduresBloc({required ProcedureRepository procedureRepository})
  : repository = procedureRepository,
    super(const ProceduresState()) {
    on<ProceduresEvent>(_onProceduresRequested);
  }
}

Future<void> _onProceduresRequested(
    ProceduresEvent event,
    Emitter<ProceduresState> emit,
  ) async {
    
  }
