part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class ScheduleRequested extends ScheduleEvent {
  const ScheduleRequested();

  @override
  List<Object> get props => [];
}
