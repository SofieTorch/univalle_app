import 'package:flutter/material.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/theme/app_colors.dart';

class SemestralGradeCard extends StatelessWidget {
  const SemestralGradeCard(this.courseGrade, {Key? key}) : super(key: key);

  final CourseGrade courseGrade;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: courseGrade.isApproved
              ? AppColors.green
              : AppColors.gray.shade100,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              courseGrade.course.subject,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: courseGrade.isApproved
                  ? Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: AppColors.white,
                      )
                  : Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: 8),
            Text(
              courseGrade.semestralGrade.toString(),
              style: courseGrade.isApproved
                  ? Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: AppColors.white)
                  : Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}
