import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/schedule/schedule.dart';

class DayScheduleList extends StatelessWidget {
  const DayScheduleList(this.day, {Key? key}) : super(key: key);
  final int day;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state.schedule.getDaySchedule(day).isEmpty) {
          final l10n = context.l10n;
          return Center(
            child: Text(l10n.dayScheduleNoClassesMessage),
          );
        }

        final daySchedule = state.schedule.getDaySchedule(day);
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: daySchedule.length,
          itemBuilder: (context, index) =>
              ScheduleClassItem(daySchedule[index]),
          separatorBuilder: (context, index) => const Divider(height: 24),
        );
      },
    );
  }
}
