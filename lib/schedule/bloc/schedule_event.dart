part of 'schedule_bloc.dart';

/// Base class for [ScheduleBloc]'s events.
abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

/// Triggered to request the schedule, at the start
/// of the SchedulePage.
class ScheduleRequested extends ScheduleEvent {
  const ScheduleRequested();

  @override
  List<Object> get props => [];
}
