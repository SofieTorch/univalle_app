import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/credit/widgets/cubit_credit/credit_item_cubit.dart';
import 'package:univalle_app/theme/app_colors.dart';

class Credit extends StatelessWidget {
  const Credit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreditItemCubit(),
      child: const EnrollmentWidgetView(),
    );
  }
}

class EnrollmentWidgetView extends StatelessWidget {
  const EnrollmentWidgetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showCredit = context.select<CreditItemCubit, bool>(
      (value) => value.state.showCredit,
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
                          .read<CreditItemCubit>()
                          .changeRequirementsVisibility();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.white,
                      padding: const EdgeInsets.all(1),
                      shape: const CircleBorder(),
                    ),
                    child: Icon(
                      showCredit ? MdiIcons.chevronUp : MdiIcons.chevronDown,
                      size: 20,
                      color: AppColors.matterhorn,
                    ),
                  ),
                ],
              ),
              if (showCredit) const EnrollmentList(),
            ],
          ),
          const SizedBox(height: 4),
          if (showCredit) const EnrollmentList(),
        ],
      ),
    );
  }
}

class EnrollmentList extends StatelessWidget {
  const EnrollmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Bs.171');
  }
}
