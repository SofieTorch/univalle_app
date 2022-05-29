import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/grades/grades.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/theme/app_colors.dart';

class DropDownGrades extends StatelessWidget {
  const DropDownGrades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        bottom: 4,
      ),
      child: Row(
        children: [
          Text(
            l10n.gradesPageManagementLabel,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.only(
              left: 8,
              top: 4,
              bottom: 4,
              right: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.shiraz.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                style: Theme.of(context).textTheme.subtitle1,
                elevation: 1,
                borderRadius: BorderRadius.circular(8),
                dropdownColor: AppColors.white,
                isDense: true,
                value: context.select<GradeListBloc, String>(
                  (bloc) => bloc.state.selectedManagement,
                ),
                items: context
                    .read<GradeListBloc>()
                    .state
                    .grades
                    .keys
                    .map(
                      (String e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  context.read<GradeListBloc>().add(ManagementChanged(value!));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
