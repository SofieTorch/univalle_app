import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/grades_repository.dart';
import 'package:univalle_app/data/repositories/schedule_repository.dart';
import 'package:univalle_app/grades/grades.dart';
import 'package:univalle_app/home/home.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/schedule/schedule.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScheduleBloc>(
          create: (context) => ScheduleBloc(
            scheduleRepository: ScheduleRepository(
              scheduleProvider: ScheduleProvider(
                storageProvider: context.read<StorageProvider>(),
              ),
              subjectsProvider: SubjectsProvider(
                storageProvider: context.read<StorageProvider>(),
              ),
            ),
          )..add(const ScheduleRequested()),
        ),
        BlocProvider(
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
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.homePageNextClassLabel,
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 8),
            BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state.status == ScheduleRequestStatus.failure) {
                  return AlertMessage(
                    '${l10n.nextClassErrorMessage} ${state.errorMessage}',
                  );
                }

                if (state.status == ScheduleRequestStatus.success) {
                  final nextClass = state.schedule.nextClass;
                  if (nextClass.isEmpty) {
                    return AlertMessage(l10n.nextClassNoMoreClassesMessage);
                  }

                  return NextClassCard(state.schedule.nextClass);
                }

                return const CircularProgressIndicator();
              },
            ),
            Text(
              'Notas',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 8),
            BlocBuilder<GradeListBloc, GradeListState>(
              builder: (context, state) {
                if (state.status == GradeListRequestStatus.failure) {
                  return AlertMessage(
                    '${l10n.nextClassErrorMessage} ${state.errorMessage}',
                  );
                }

                if (state.status == GradeListRequestStatus.success) {
                  final management = state.grades.keys.toList()[0];
                  final gradeList = state.grades[management]!;
                  return ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 118,
                      minHeight: 96,
                    ),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: gradeList.length,
                      itemBuilder: (_, index) {
                        return SemestralGradeCard(gradeList[index]);
                      },
                      separatorBuilder: (_, index) => const SizedBox(width: 16),
                    ),
                  );
                }

                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
