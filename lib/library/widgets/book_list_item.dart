import 'package:flutter/material.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/library/library.dart';
import 'package:univalle_app/models/book.dart';
import 'package:univalle_app/theme/app_colors.dart';

class BookListItem extends StatelessWidget {
  const BookListItem(this.book, {Key? key}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 4),
        Text(
          book.authors.join(', '),
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: AppColors.gray.shade400),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            if (book.available)
              const BookAvailableChip()
            else
              const BookUnavailableChip(),
            const SizedBox(width: 6),
            Text(
              '${context.l10n.libraryLoanCampusLabel} ${book.campus.name}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: AppColors.gray),
            ),
          ],
        ),
      ],
    );
  }
}
