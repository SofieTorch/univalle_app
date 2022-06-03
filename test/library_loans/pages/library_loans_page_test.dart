import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/library_loans/bloc/loan_list_bloc.dart';
import 'package:univalle_app/library_loans/library_loans.dart';
import 'package:univalle_app/library_loans/pages/library_loans_page.dart';
import 'package:univalle_app/models/models.dart';

class MockLoanListBloc extends MockBloc<LoanListEvent, LoanListState>
    implements LoanListBloc {}

void main() {
  group('LibraryLoans View', () {
    late MockLoanListBloc loanListBloc;

    setUp(() {
      loanListBloc = MockLoanListBloc();
      when(() => loanListBloc.state).thenReturn(const LoanListState());
    });

    testWidgets(
      '''
      Shows WithoutLoansMessage
      when state.status is LoanListRequestStatus.success
      and state.loans is empty.
      ''',
      (tester) async {
        whenListen(
          loanListBloc,
          Stream<LoanListState>.fromIterable(const [
            LoanListState(
              status: LoanListRequestStatus.success,
            )
          ]),
        );

        await tester.pumpApp(bloc: loanListBloc);
        await tester.pump();

        expect(find.byType(WithoutLoansMessage), findsOneWidget);
        expect(find.byType(ListView), findsNothing);
        expect(find.byType(LoanItem), findsNothing);
      },
    );

    testWidgets(
      '''
      Shows a list of LoanItem
      when state.status is LoanListRequestStatus.success
      and state.loans is not empty.
      ''',
      (tester) async {
        whenListen(
          loanListBloc,
          Stream<LoanListState>.fromIterable([
            LoanListState(
              status: LoanListRequestStatus.success,
              loans: [
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
                Loan(
                  book: const Book(
                    id: 16,
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
                  returnDate: DateTime(0),
                ),
              ],
            ),
          ]),
        );

        await tester.pumpApp(bloc: loanListBloc);
        await tester.pump();

        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(LoanItem), findsNWidgets(2));
        expect(find.text('Returned'), findsOneWidget);
        expect(find.text('To return'), findsOneWidget);
      },
    );
  });
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required LoanListBloc bloc,
  }) {
    return pumpWidget(
      BlocProvider<LoanListBloc>.value(
        value: bloc,
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: LibraryLoansView()),
        ),
      ),
    );
  }
}
