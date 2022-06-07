import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/enrollment/widgets/cubit_enrollment/enrollment_item_cubit.dart';
import 'package:univalle_app/theme/app_colors.dart';

class Enrollment extends StatelessWidget {
  const Enrollment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EnrollmentItemCubit(),
      child: const EnrollmentWidgetView(),
    );
  }
}

class EnrollmentWidgetView extends StatelessWidget {
  const EnrollmentWidgetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showEnrollment = context.select<EnrollmentItemCubit, bool>(
      (value) => value.state.showEnrollment,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Costo de matrícula',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColors.matterhorn),
                  ),
                  //button to display the list payment places
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<EnrollmentItemCubit>()
                          .changeRequirementsVisibility();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.white,
                      padding: const EdgeInsets.all(1),
                      shape: const CircleBorder(),
                    ),
                    child: Icon(
                      showEnrollment
                          ? MdiIcons.chevronUp
                          : MdiIcons.chevronDown,
                      size: 20,
                      color: AppColors.matterhorn,
                    ),
                  ),
                ],
              ),
              if (showEnrollment) const EnrollmentList(),
            ],
          ),
          const SizedBox(height: 4),
          if (showEnrollment) const EnrollmentList(),
        ],
      ),
    );
  }
}

class EnrollmentList extends StatelessWidget {
  const EnrollmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Bs.0');
  }
}
