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
    this.available = true,
    this.campus = Campus.empty,
  });

  factory Book.fromJson(dynamic json, [Campus? campus]) {
    final parsedJson = json as Map<String, dynamic>;
    return Book(
      id: parsedJson['id'] as int,
      title: parsedJson['title'] as String,
      authors: (parsedJson['authors'] as List<dynamic>)
          .map((dynamic e) => e.toString())
          .toList(),
      content: (parsedJson['content'] as List<dynamic>)
          .map((dynamic e) => e.toString())
          .toList(),
      editorial: parsedJson['editorial'] as String,
      edition: parsedJson['edition'] as int,
      year: parsedJson['publicationYear'] as int,
      isbn: parsedJson['isbn'] as String,
      country: parsedJson['publicatonCountry'] as String,
      language: parsedJson['language'] as String,
      pages: parsedJson['pages'] as int,
      available: parsedJson['available'] as bool,
      campus: campus ?? Campus.empty,
    );
  }

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
  final bool available;
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
        available,
        campus,
      ];
}
