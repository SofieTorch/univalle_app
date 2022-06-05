import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/theme/app_colors.dart';

class PaymentPlaces extends StatelessWidget {
  const PaymentPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) {
            return const PaymentPlacesView();
          },
        ),
      ],
    );
  }
}

class PaymentPlacesView extends StatelessWidget {
  const PaymentPlacesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Datos de Interés',
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Lugares de pago',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColors.matterhorn),
                  ),
                  //button to display the list payment places
                  ElevatedButton(
                    onPressed: () {
                      //context
                      //.read<ProcedureItemCubit>()
                      //.changeRequirementsVisibility();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.white,
                      padding: const EdgeInsets.all(1),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      MdiIcons.chevronDown,
                      size: 20,
                      color: AppColors.matterhorn,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
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
                      //context
                      //.read<ProcedureItemCubit>()
                      //.changeRequirementsVisibility();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.white,
                      padding: const EdgeInsets.all(1),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      MdiIcons.chevronDown,
                      size: 20,
                      color: AppColors.matterhorn,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Costo por crédito',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColors.matterhorn),
                  ),
                  //button to display the list payment places
                  ElevatedButton(
                    onPressed: () {
                      //context
                      //.read<ProcedureItemCubit>()
                      //.changeRequirementsVisibility();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.white,
                      padding: const EdgeInsets.all(1),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      MdiIcons.chevronDown,
                      size: 20,
                      color: AppColors.matterhorn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
