import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/library/library.dart';
import 'package:univalle_app/models/book.dart';
import 'package:univalle_app/theme/theme.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage(this.book, {Key? key}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de libro'),
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
                'Contenido',
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
                      'Editorial: ${book.editorial} - ${book.edition}º Edicion',
                    ),
                    Text(
                      '${book.year} - ${book.country}',
                    ),
                    Text('ISBN ${book.isbn}'),
                    Row(
                      children: [
                        Text('Idioma: ${_mapLanguage(book.language)} '),
                        Text('- ${book.pages} Paginas'),
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

  String _mapLanguage(String languageAbrev) {
    final languages = {
      'es': 'Español',
      'en': 'Ingles',
    };

    return languages[languageAbrev] ?? 'Desconocido';
  }
}
