import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/schedule_repository.dart';
import 'package:univalle_app/models/schedule.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc({
    required ScheduleRepository scheduleRepository,
  })  : _repository = scheduleRepository,
        super(const ScheduleState()) {
    on<ScheduleRequested>(_onScheduleRequested);
  }

  final ScheduleRepository _repository;

  Future<void> _onScheduleRequested(
    ScheduleRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(status: ScheduleRequestStatus.loading));
    try {
      final schedule = await _repository.getSchedule();
      emit(
        state.copyWith(
          status: ScheduleRequestStatus.success,
          schedule: schedule,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ScheduleRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
