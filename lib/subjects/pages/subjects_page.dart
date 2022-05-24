import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/academic/academic.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/subjects/subjects.dart';

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
      child: const SubjectsView(),
    );
  }
}

class SubjectsView extends StatelessWidget {
  const SubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectListBloc, SubjectListState>(
      builder: (context, state) {
        if (state.status == SubjectListRequestStatus.failure) {
          return Center(child: Text(state.errorMessage!));
        }

        if (state.status == SubjectListRequestStatus.success) {
          if (state.courses.isEmpty) {
            return const NoEnrolledMessage();
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
