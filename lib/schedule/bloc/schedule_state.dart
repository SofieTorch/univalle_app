part of 'schedule_bloc.dart';

/// Http request's status when making the schedule request.
enum ScheduleRequestStatus { initial, loading, success, failure }

/// State emitted by [ScheduleBloc].
///
/// Contains the schedule and its request status
/// ([ScheduleRequestStatus]), in addition of the
/// error message incase the request throws an error.
class ScheduleState extends Equatable {
  const ScheduleState({
    this.status = ScheduleRequestStatus.initial,
    this.schedule = Schedule.empty,
    this.errorMessage = '',
  });

  /// Status of the http request.
  final ScheduleRequestStatus status;

  /// Error message when the http request was unsuccessful
  /// or something unexpected happen.
  final String errorMessage;

  final Schedule schedule;

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
