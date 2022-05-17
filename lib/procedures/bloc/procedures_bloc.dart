import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'procedures_event.dart';
part 'procedures_state.dart';

class ProceduresBloc extends Bloc<ProceduresEvent, ProceduresState> {
  ProceduresBloc() : super(ProceduresInitial()) {
    on<ProceduresEvent>((event, emit) {
      // TODO: implement event handler
      
    });
  }
}
