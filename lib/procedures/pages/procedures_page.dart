import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/data/providers/procedures_provider.dart';
import 'package:univalle_app/data/repositories/procedures_repository.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/procedure.dart';
import 'package:univalle_app/procedures/bloc/procedures_bloc.dart';
import 'package:univalle_app/theme/app_colors.dart';
import 'package:univalle_app/theme/app_colors.dart';

class ProceduresPage extends StatelessWidget {
  const ProceduresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProceduresBloc>(
      create: (context) => ProceduresBloc(
        procedureRepository: ProcedureRepository(
          proceduresProvider: ProceduresProvider(),
        ),
      )..add(ProcedureListRequested()),
      child: const _ProceduresView(),
    );
  }
}

class _ProceduresView extends StatelessWidget {
  const _ProceduresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pageTitleProcedures),
      ),
      //Create Cards
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<ProceduresBloc, ProceduresState>(
            builder: (context, state) {
              if (state.status == ProcedureListRequestStatus.failure) {
                return Text(state.errorMessage!);
              }

              if (state.status == ProcedureListRequestStatus.success) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  itemCount: state.procedures.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) =>
                      ProcedureCard(state.procedures[index]),
                );
              }

              return const CircularProgressIndicator();
              // return Column(
              //   children: <Widget>[
              //     //metodos para los card
              //     // const ProcedureCard(),
              //     // const ProcedureCard(),
              //     // const ProcedureCard(),
              //     Container(
              //       height: 130,
              //       width: 300,
              //       child: Text(
              //         'Requisitos:',
              //         style: TextStyle(
              //           fontSize: 20,
              //         ),
              //       ),
              //     ),
              //   ],
              // );
            },
          ),
        ),
      ),
    );
  }
}

class ProcedureCard extends StatelessWidget {
  const ProcedureCard(this.procedure, {Key? key}) : super(key: key);

  final Procedure procedure;

  @override
  Widget build(BuildContext context) {
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
                      backgroundColor: AppColors.shiraz.shade100),
                  const SizedBox(
                    width: 4,
                  ),
                  Chip(
                      label: Text(
                        'Costo ${procedure.price} bs.',
                        style: Theme.of(context).textTheme.overline,
                      ),
                      backgroundColor: AppColors.gray.shade200),
                ],
              ),
              const Icon(MdiIcons.chevronDown),
            ],
          ),
        ],
      ),
    );
  }
}
