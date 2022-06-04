import 'package:flutter/material.dart';
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
              .headline3!
              .copyWith(color: AppColors.gray),
        ),
      ],
    );
  }
}
