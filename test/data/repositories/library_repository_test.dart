import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/library_provider.dart';
import 'package:univalle_app/data/repositories/library_repository.dart';
import 'package:univalle_app/models/models.dart';

class MockLibraryProvider extends Mock implements LibraryProvider {}

void main() {
  group('LibraryRepository', () {
    late MockLibraryProvider mockLibraryProvider;
    late LibraryRepository repository;

    setUp(() {
      mockLibraryProvider = MockLibraryProvider();
      repository = LibraryRepository(libraryProvider: mockLibraryProvider);
    });

    test('getLoans() request returns List<Loan> successfully.', () {
      const loansJson = '''
          {
            "loans": [
              {
                "book": {
                    "authors": [
                        "Amaro Soriano José Enrique"
                    ],
                    "available": true,
                    "content": [
                        "Introducción",
                        "Escribir y manipular texto"
                    ],
                    "edition": 1,
                    "editorial": "Marcombo",
                    "id": 15,
                    "isbn": "978-8426726766",
                    "language": "es",
                    "pages": 250,
                    "publicationYear": 2012,
                    "publicatonCountry": "España",
                    "title": "Android: Programación de dispositivos móviles"
                },
                "campus": {
                    "address": "Calle Guillermina Martínez",
                    "id": 210,
                    "name": "Campus Tiquipaya"
                },
                "loanDate": "15/03/2022",
                "returnDate": "02/04/2022"
              }
            ]
          }
        ''';

      final loans = [
        Loan(
          book: const Book(
            id: 15,
            authors: [
              'Amaro Soriano José Enrique',
            ],
            content: [
              'Introducción',
              'Escribir y manipular texto',
            ],
            editorial: 'Marcombo',
            isbn: '978-8426726766',
            language: 'es',
            pages: 250,
            year: 2012,
            country: 'España',
            title: 'Android: Programación de dispositivos móviles',
            campus: Campus(
              id: 210,
              address: 'Calle Guillermina Martínez',
              name: 'Campus Tiquipaya',
            ),
          ),
          loanDate: DateTime(2022, 3, 15),
          returnDate: DateTime(2022, 4, 2),
        ),
      ];

      when(() => mockLibraryProvider.requestLoans()).thenAnswer(
        (_) => Future<Response>(() => Response(loansJson, 200)),
      );

      final future = repository.getLoans();
      expect(future, completion(equals(loans)));
    });

    test(
      'getLoans() request throws an error when response code is not 200.',
      () {
        when(() => mockLibraryProvider.requestLoans()).thenAnswer(
          (invocation) => Future<Response>(() => Response('', 500)),
        );

        expect(repository.getLoans(), throwsException);
      },
    );
  });
}
