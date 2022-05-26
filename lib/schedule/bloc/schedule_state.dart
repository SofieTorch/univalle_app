part of 'schedule_bloc.dart';

enum ScheduleRequestStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  const ScheduleState({
    this.status = ScheduleRequestStatus.initial,
    this.schedule = Schedule.empty,
    this.errorMessage = '',
  });

  final ScheduleRequestStatus status;
  final Schedule schedule;
  final String errorMessage;

  ScheduleState copyWith({
    ScheduleRequestStatus? status,
    Schedule? schedule,
    String? errorMessage,
    int? selectedDay,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      schedule: schedule ?? this.schedule,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, schedule, errorMessage];
}
