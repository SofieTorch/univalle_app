import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/home/home.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/schedule/schedule.dart';

class NextClassBuilder extends StatelessWidget {
  const NextClassBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ScheduleBloc, ScheduleState>(
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
    );
  }
}
