import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/grades/grades.dart';
import 'package:univalle_app/home/home.dart';
import 'package:univalle_app/l10n/l10n.dart';

/// Builds the grade list of the last management
/// when [GradeListState.status] is [GradeListRequestStatus.success],
/// using [SemestralGradeCard].
///
/// Shows an [AlertMessage] with the error message in case that
/// [GradeListState.status] is [GradeListRequestStatus.failure].
///
/// Shows a CircularProgressIndicator otherwise.
class GradesBriefBuilder extends StatelessWidget {
  const GradesBriefBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<GradeListBloc, GradeListState>(
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
    );
  }
}
