import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/class_session.dart';

class ScheduleClassItem extends StatelessWidget {
  const ScheduleClassItem(this.classSession, {Key? key}) : super(key: key);

  final ClassSession classSession;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        SizedBox(
          width: 42,
          child: Column(
            children: [
              Text(
                // ignore: lines_longer_than_80_chars
                '${classSession.startTime.hour}:${classSession.startTime.minute}',
              ),
              Text(
                '${classSession.endTime.hour}:${classSession.endTime.minute}',
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classSession.course.subject,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: 4),
            Text(
              '${l10n.subjectItemGroupLabel} ${classSession.course.group}',
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(MdiIcons.mapMarker, size: 24),
                const SizedBox(width: 4),
                Text(
                  classSession.classroom,
                  style: Theme.of(context).textTheme.overline,
                ),
                const SizedBox(width: 12),
                const Icon(MdiIcons.cardAccountDetailsOutline, size: 24),
                const SizedBox(width: 4),
                Text(
                  classSession.course.teacher,
                  style: Theme.of(context).textTheme.overline,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
