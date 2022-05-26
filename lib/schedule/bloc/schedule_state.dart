part of 'schedule_bloc.dart';

enum ScheduleRequestStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  const ScheduleState({
    this.status = ScheduleRequestStatus.initial,
    this.schedule = Schedule.empty,
    this.errorMessage = '',
    this.selectedDay = 1,
  });

  final ScheduleRequestStatus status;
  final Schedule schedule;
  final String errorMessage;
  final int selectedDay;

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
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  List<Object> get props => [status, schedule, errorMessage, selectedDay];
}
