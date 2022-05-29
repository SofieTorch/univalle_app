import 'package:flutter/material.dart';
import 'package:univalle_app/grades/widgets/widgets.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/models.dart';

class CourseGradesItem extends StatelessWidget {
  const CourseGradesItem(this.courseGrade, {Key? key}) : super(key: key);

  final CourseGrade courseGrade;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          courseGrade.semestralGrade.toString(),
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          courseGrade.course.subject,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 6),
        GradesBar(courseGrade),
        const SizedBox(height: 12),
        ..._buildSingleGradeBars(courseGrade, context),
        Row(
          children: [
            Text(l10n.gradesPageFinalExamLabel),
            const SizedBox(width: 8),
            SingleGradeBar(
              grade: courseGrade.finalExam,
              color: Colors.green.shade100,
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildSingleGradeBars(
    CourseGrade courseGrade,
    BuildContext context,
  ) {
    final widgets = <Widget>[];
    final l10n = context.l10n;
    final labels = [
      l10n.gradesPageFirstMidtermLabel,
      l10n.gradesPageSecondMidtermLabel,
      l10n.gradesPageThirdMidtermLabel,
      l10n.gradesPageFourthMidtermLabel,
    ];
    final colors = [
      Colors.pink.shade100,
      Colors.blue.shade100,
      Colors.orange.shade100,
      Colors.cyan.shade100,
    ];

    for (var i = 0; i < courseGrade.partials.length; i++) {
      widgets
        ..add(
          Row(
            children: [
              Text('${labels[i]} ${l10n.gradesPageMidtermLabel}'),
              const SizedBox(width: 8),
              SingleGradeBar(
                grade: courseGrade.partials[i],
                color: colors[i],
              ),
            ],
          ),
        )
        ..add(const SizedBox(height: 8));
    }

    return widgets;
  }
}
