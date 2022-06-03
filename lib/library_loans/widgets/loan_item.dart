import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/models/models.dart';
import 'package:univalle_app/theme/app_colors.dart';

class LoanItem extends StatelessWidget {
  const LoanItem(this.loan, {Key? key}) : super(key: key);

  final Loan loan;

  @override
  Widget build(BuildContext context) {
    final loanReturned = loan.returnDate != DateTime(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loan.book.title,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 2),
        Text(
          loan.book.authors.join(', '),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AppColors.gray),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            if (loanReturned)
              const _LoanReturnedChip()
            else
              const _LoanToReturnChip(),
            const SizedBox(width: 6),
            Text(
              'en ${loan.book.campus.name}',
              style: Theme.of(context)
                  .textTheme
                  .overline!
                  .copyWith(color: AppColors.gray),
            ),
          ],
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

class _LoanToReturnChip extends StatelessWidget {
  const _LoanToReturnChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        children: const [
          Text('Por devolver'),
          SizedBox(width: 4),
          Icon(
            MdiIcons.clockEnd,
            color: AppColors.white,
            size: 16,
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

class _LoanReturnedChip extends StatelessWidget {
  const _LoanReturnedChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        children: const [
          Text('Devuelto'),
          SizedBox(width: 4),
          Icon(
            MdiIcons.checkCircleOutline,
            color: AppColors.white,
            size: 16,
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
