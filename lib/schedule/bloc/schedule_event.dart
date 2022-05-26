part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class ScheduleRequested extends ScheduleEvent {
  const ScheduleRequested();

  @override
  List<Object> get props => [];
}

class DayScheduleChanged extends ScheduleEvent {
  const DayScheduleChanged(this.day);

  final int day;

  @override
  List<Object?> get props => [day];
}
