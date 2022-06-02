import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/schedule_repository.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/schedule/schedule.dart';
import 'package:univalle_app/theme/theme.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleBloc>(
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
      child: const ScheduleView(),
    );
  }
}

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state.status == ScheduleRequestStatus.failure) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        if (state.status == ScheduleRequestStatus.success) {
          final days = <int, String>{
            1: l10n.scheduleMondayLabel,
            2: l10n.scheduleTuesdayLabel,
            3: l10n.scheduleWednesdayLabel,
            4: l10n.scheduleThrusdayLabel,
            5: l10n.scheduleFridayLabel,
            6: l10n.scheduleSaturdayLabel,
          };

          return DefaultTabController(
            length: 6,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TabBar(
                    isScrollable: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.shiraz,
                    ),
                    labelColor: AppColors.white,
                    unselectedLabelColor: AppColors.matterhorn,
                    tabs: days.values
                        .map((e) => _buildDayTab(e, context))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: TabBarView(
                      children: days.keys.map(DayScheduleList.new).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Tab _buildDayTab(String day, BuildContext context) {
    return Tab(
      height: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day[0],
            style: GoogleFonts.raleway(
              fontSize: 20,
              fontWeight: AppFontWeight.semibold,
            ),
          ),
          Text(day),
        ],
      ),
    );
  }
}
