import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/grades_repository.dart';
import 'package:univalle_app/grades/grades.dart';

class GradesPage extends StatelessWidget {
  const GradesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GradeListBloc>(
      create: (context) => GradeListBloc(
        gradesRepository: GradesRepository(
          gradesProvider: GradesProvider(
            storageProvider: context.read<StorageProvider>(),
          ),
          subjectsProvider: SubjectsProvider(
            storageProvider: context.read<StorageProvider>(),
          ),
        ),
      )..add(const GradeListRequested()),
      child: const GradesView(),
    );
  }
}

class GradesView extends StatelessWidget {
  const GradesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradeListBloc, GradeListState>(
      builder: (context, state) {
        if (state.status == GradeListRequestStatus.failure) {
          return Center(child: Text(state.errorMessage));
        }

        if (state.status == GradeListRequestStatus.success) {
          return Column(
            children: [
              const DropDownGrades(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: state.grades[state.selectedManagement]!.length,
                  itemBuilder: (_, index) {
                    final courseGrade =
                        state.grades[state.selectedManagement]![index];
                    return Padding(
                      padding: const EdgeInsets.all(14),
                      child: CourseGradesItem(courseGrade),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
