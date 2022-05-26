import 'package:equatable/equatable.dart';
import 'package:univalle_app/models/models.dart';

class Schedule extends Equatable {
  const Schedule(this.scheduleMap);

  static const empty = Schedule({});

  final Map<int, List<ClassSession>> scheduleMap;

  List<ClassSession> getDaySchedule(int day) => scheduleMap[day] ?? [];

  @override
  List<Object?> get props => [scheduleMap];
}
