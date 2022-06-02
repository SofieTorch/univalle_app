import 'package:equatable/equatable.dart';
import 'package:univalle_app/models/models.dart';

class Book extends Equatable {
  const Book({
    this.id = 0,
    this.title = '',
    this.authors = const [],
    this.content = const [],
    this.editorial = '',
    this.edition = 1,
    this.year = 0,
    this.isbn = '',
    this.country = '',
    this.language = '',
    this.pages = 1,
    this.campus = Campus.empty,
  });

  final int id;
  final String title;
  final List<String> authors;
  final List<String> content;
  final String editorial;
  final int edition;
  final int year;
  final String isbn;
  final String country;
  final String language;
  final int pages;
  final Campus campus;

  @override
  List<Object?> get props => [
        id,
        title,
        authors,
        content,
        editorial,
        edition,
        year,
        isbn,
        country,
        language,
        pages,
        campus,
      ];
}
