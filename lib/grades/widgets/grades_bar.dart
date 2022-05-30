import 'package:flutter/material.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/theme/app_colors.dart';

/// Graphic bar for [CourseGrade.semestralGrade],
/// divided by each [CourseGrade.partials] and [CourseGrade.finalExam],
/// based on their weight.
class GradesBar extends StatelessWidget {
  const GradesBar(this.courseGrade, {Key? key}) : super(key: key);

  final CourseGrade courseGrade;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32;
    final finalPercentage = courseGrade.finalExam * courseGrade.finalWeight;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray.shade100,
        borderRadius: BorderRadius.circular(50),
      ),
      height: 18,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Row(
          children: [
            ..._buildMidtermsBar(context),
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              width: width / 100 * finalPercentage,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMidtermsBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32;
    final colors = [
      Colors.pink.shade200,
      const Color(0xFF94C4FE),
      const Color(0xFFFFB393),
      Colors.cyan.shade200,
    ];

    final widgets = <Container>[];

    for (var i = 0; i < courseGrade.partials.length; i++) {
      final grade = courseGrade.partials[i];
      final percentage = grade * courseGrade.midtermsWeight;
      widgets.add(
        Container(
          color: colors[i],
          width: (width / 100) * percentage,
        ),
      );
    }
    return widgets;
  }
}
