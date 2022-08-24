import 'package:equatable/equatable.dart';
import 'package:univalle_app/models/models.dart';

class Schedule extends Equatable {
  const Schedule(this.scheduleMap);

  static const empty = Schedule({});

  final Map<int, List<ClassSession>> scheduleMap;

  /// List of class sessions on the [day], returns an
  /// empty list if there is none.
  List<ClassSession> getDaySchedule(int day) => scheduleMap[day] ?? [];

  /// Next class for current day, returns [ClassSession.empty]
  /// if there is no one.
  ClassSession get nextClass {
    final today = DateTime.now();
    final todayClasses = scheduleMap[today.weekday] ?? [];

    final classSession = todayClasses.firstWhere(
      (element) =>
          element.startTime.hour > today.hour ||
          (element.startTime.hour == today.hour &&
              element.startTime.minute > today.minute),
      orElse: ClassSession.empty,
    );

    return classSession;
  }

  @override
  List<Object?> get props => [scheduleMap];
}
