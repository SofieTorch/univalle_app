import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/theme/app_colors.dart';

class BookAvailableChip extends StatelessWidget {
  const BookAvailableChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        children: [
          Text(context.l10n.libraryLoanToReturnChipLabel),
          const SizedBox(width: 4),
          const Icon(
            MdiIcons.checkCircleOutline,
            color: AppColors.white,
            size: 18,
          ),
        ],
      ),
      backgroundColor: AppColors.green,
      labelStyle: Theme.of(context)
          .textTheme
          .overline!
          .copyWith(color: AppColors.white),
    );
  }
}

class BookUnavailableChip extends StatelessWidget {
  const BookUnavailableChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        children: [
          Text(context.l10n.libraryLoanReturnedChipLabel),
          const SizedBox(width: 4),
          const Icon(
            MdiIcons.bookOff,
            color: AppColors.white,
            size: 18,
          ),
        ],
      ),
      backgroundColor: AppColors.shiraz.shade300,
      labelStyle: Theme.of(context)
          .textTheme
          .overline!
          .copyWith(color: AppColors.white),
    );
  }
}
