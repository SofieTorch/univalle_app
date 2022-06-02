import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/models/procedure.dart';
import 'package:univalle_app/procedures/widgets/cubit/procedure_item_cubit.dart';
import 'package:univalle_app/theme/app_colors.dart';

class ProcedureCard extends StatelessWidget {
  const ProcedureCard(this.procedure, {Key? key}) : super(key: key);

  final Procedure procedure;

  @override
  Widget build(BuildContext context) {
    //IconData iconDataAux = iconData;
    return BlocProvider(
      create: (_) => ProcedureItemCubit(procedure),
      child: const ProcedureCardView(),
    );
  }
}

class ProcedureCardView extends StatelessWidget {
  const ProcedureCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final procedure = context.read<ProcedureItemCubit>().state.procedure;
    final showRequirements = context.select<ProcedureItemCubit, bool>(
      (value) => value.state.showRequirements,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            procedure.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 4),
          Text(
            '${procedure.estimatedDays} dias estimados',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AppColors.gray),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Chip(
                    label: Text(
                      procedure.requiresInvoice
                          ? 'Precisa factura'
                          : 'No precisa factura',
                      style: Theme.of(context).textTheme.overline,
                    ),
                    backgroundColor: AppColors.shiraz.shade100,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Chip(
                    label: Text(
                      'Costo ${procedure.price} bs.',
                      style: Theme.of(context).textTheme.overline,
                    ),
                    backgroundColor: AppColors.gray.shade200,
                  ),
                ],
              ),

              //button to display the list
              ElevatedButton(
                onPressed: () {
                  context
                      .read<ProcedureItemCubit>()
                      .changeRequirementsVisibility();
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.white,
                  padding: const EdgeInsets.all(2),
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  showRequirements ? MdiIcons.chevronUp : MdiIcons.chevronDown,
                  size: 30,
                  color: AppColors.matterhorn,
                ),
              ),
            ],
          ),
          if (showRequirements) RequirementsList(procedure),
        ],
      ),
    );
  }
}

class RequirementsList extends StatelessWidget {
  const RequirementsList(this.procedure, {Key? key}) : super(key: key);
  final Procedure procedure;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      itemCount: procedure.requirements.length,
      shrinkWrap: true,
      itemBuilder: (_, index) => Text(procedure.requirements[index]),
    );
  }
}
