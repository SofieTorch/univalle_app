import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/subjects/subjects.dart';
import 'package:univalle_app/theme/theme.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectListBloc(
        subjectsRepository: SubjectsRepository(
          storageProvider: context.read<StorageProvider>(),
        ),
      )..add(SubjectListRequested()),
      child: const _SubjectsView(),
    );
  }
}

class _SubjectsView extends StatelessWidget {
  const _SubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<SubjectListBloc, SubjectListState>(
      builder: (context, state) {
        if (state.status == SubjectListRequestStatus.failure) {
          return Center(child: Text(state.errorMessage!));
        }

        if (state.status == SubjectListRequestStatus.success) {
          if (state.courses.isEmpty) {
            return Center(child: Text(l10n.subjectListEmpty));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: state.courses.length,
            itemBuilder: (_, index) => SubjectListItem(state.courses[index]),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
