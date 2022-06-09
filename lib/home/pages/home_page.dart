import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/grades_repository.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/data/repositories/schedule_repository.dart';
import 'package:univalle_app/grades/grades.dart';
import 'package:univalle_app/home/widgets/alert_message.dart';
import 'package:univalle_app/home/widgets/grades_brief_builder.dart';
import 'package:univalle_app/home/widgets/next_class_builder.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/payments/payments_fees_bloc/payments_fees_bloc.dart';
import 'package:univalle_app/payments/widgets/monthly_fees.dart';
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
        BlocProvider<PaymentsFeesBloc>(
          create: (context) => PaymentsFeesBloc(
            paymentsFeesRepository: PaymentsFeesRepository(
              paymentsFeesProvider: PaymentsFeesProvider(
                storageProvider: context.read<StorageProvider>(),
              ),
            ),
          )..add(PaymentsFeesRequested()),
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
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<PaymentsFeesBloc, PaymentsFeesState>(
              builder: (context, state) {
                if (state.status == PaymentsRequestStatus.failure) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                }

                if (state.status == PaymentsRequestStatus.success) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Pagos pendientes',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (state.fees.isEmpty)
                        const AlertMessage('No tienes pagos pendientes')
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.fees.length,
                          itemBuilder: (_, index) =>
                              MonthlyFees(index, state.fees[index]),
                          separatorBuilder: (_, __) => const Divider(),
                        )
                    ],
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
