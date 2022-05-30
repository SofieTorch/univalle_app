import 'package:flutter/material.dart';
import 'package:univalle_app/theme/app_colors.dart';

/// Graphic bar to display a grade over 100,
/// similar to a progress bar.
class SingleGradeBar extends StatelessWidget {
  const SingleGradeBar({required this.grade, required this.color, Key? key})
      : super(key: key);

  final double grade;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gray.shade100,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 18,
        alignment: Alignment.centerLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: LayoutBuilder(
            builder: (_, constraints) => Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              width: constraints.maxWidth / 100 * grade,
              alignment: Alignment.center,
              child: Text(
                grade.toStringAsFixed(1),
                style: Theme.of(context).textTheme.overline,
                // .copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
