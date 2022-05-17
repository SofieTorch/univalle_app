import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/theme/theme.dart';

class SubjectListItem extends StatelessWidget {
  const SubjectListItem(this.course, {Key? key}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: AppColors.gray.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.subject,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              '${l10n.subjectItemGroupLabel} ${course.group}',
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(MdiIcons.cardAccountDetailsOutline),
                const SizedBox(width: 8),
                Text(course.teacher),
              ],
            )
          ],
        ),
      ),
    );
  }
}
