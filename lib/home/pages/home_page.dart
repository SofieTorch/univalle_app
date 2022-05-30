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
            const NextClassBuilder(),
            const SizedBox(height: 16),
            Text(
              l10n.homePageGradesLabel,
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 8),
            const GradesBriefBuilder(),
          ],
        ),
      ),
    );
  }
}
