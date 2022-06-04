import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/grades_repository.dart';
import 'package:univalle_app/data/repositories/schedule_repository.dart';
import 'package:univalle_app/grades/grades.dart';
import 'package:univalle_app/schedule/schedule.dart';
import 'package:univalle_app/theme/theme.dart';

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
    //final l10n = context.l10n;

    // ignore: prefer_const_constructors
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
