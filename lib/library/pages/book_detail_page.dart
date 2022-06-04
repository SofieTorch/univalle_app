import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/library/library.dart';
import 'package:univalle_app/models/book.dart';
import 'package:univalle_app/theme/theme.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage(this.book, {Key? key}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.bookDetailPageAppBar),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.title,
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 6),
              Text(
                book.authors.join(', '),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AppColors.gray.shade400),
              ),
              const SizedBox(height: 6),
              if (book.available)
                const BookAvailableChip()
              else
                const BookUnavailableChip(),
              const SizedBox(height: 16),
              Text(
                l10n.bookDetailPageContentLabel,
                style: Theme.of(context).textTheme.headline3,
              ),
              ...book.content.map(
                (e) => Row(
                  children: [
                    const Icon(MdiIcons.circleSmall),
                    Expanded(child: Text(e)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.gray.shade100,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${l10n.bookDetailPageEditorialLabel}: ${book.editorial} - ${book.edition}º ${l10n.bookDetailPageEditionLabel}',
                    ),
                    Text(
                      '${book.year} - ${book.country}',
                    ),
                    Text('ISBN ${book.isbn}'),
                    Row(
                      children: [
                        Text(
                          '${l10n.bookDetailPageLanguageLabel}: ${_mapLanguage(book.language, l10n)} ',
                        ),
                        Text(
                            '- ${book.pages} ${l10n.bookDetailPagePagesLabel}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _mapLanguage(String languageAbrev, AppLocalizations l10n) {
    final languages = {
      'es': l10n.esLanguageName,
      'en': l10n.enLanguageName,
    };

    return languages[languageAbrev] ?? 'Desconocido';
  }
}
