import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/providers/procedures_provider.dart';
import 'package:univalle_app/data/repositories/procedures_repository.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/procedures/bloc/procedures_bloc.dart';
import 'package:univalle_app/procedures/widgets/procedure_card.dart';

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
      child: const ProceduresView(),
    );
  }
}

class ProceduresView extends StatelessWidget {
  const ProceduresView({Key? key}) : super(key: key);

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
                return Text(state.errorMessage);
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
            },
          ),
        ),
      ),
    );
  }
}
