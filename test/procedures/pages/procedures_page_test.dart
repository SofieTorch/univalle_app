import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/models/procedure.dart';
import 'package:univalle_app/procedures/bloc/procedures_bloc.dart';
import 'package:univalle_app/procedures/procedures.dart';

class MockProcedureBloc extends MockBloc<ProceduresEvent, ProceduresState>
    implements ProceduresBloc {}

void main() {
  group('Procedure View', () {
    late MockProcedureBloc procedureBloc;
    setUp(() {
      procedureBloc = MockProcedureBloc();
      when(() => procedureBloc.state).thenReturn(const ProceduresState());
    });
    testWidgets(
      '''
      Shows a CircularProgressIndicator
      when state.status is ProcedureListRequestStatus.loading.
      ''',
      (tester) async {
        whenListen(
          procedureBloc,
          Stream<ProceduresState>.fromIterable([
            const ProceduresState(
              status: ProcedureListRequestStatus.loading,
            ),
          ]),
        );

        await tester.pumpApp(bloc: procedureBloc);
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );
    testWidgets(
      '''
      Shows an error message
      when state.status is ProcedureListRequestStatus.failure.
      ''',
      (tester) async {
        whenListen(
          procedureBloc,
          Stream<ProceduresState>.fromIterable([
            const ProceduresState(
              status: ProcedureListRequestStatus.failure,
              errorMessage: 'Error message test',
            ),
          ]),
        );

        await tester.pumpApp(bloc: procedureBloc);
        await tester.pump();

        expect(find.text('Error message test'), findsOneWidget);
      },
    );
    testWidgets(
      '''

      when state.status is ProcedureListRequestStatus.success
      ''',
      (tester) async {
        whenListen(
          procedureBloc,
          Stream<ProceduresState>.fromIterable([
            const ProceduresState(
              status: ProcedureListRequestStatus.success,
              procedures: [
                Procedure(
                  name: 'Certificado de calificaciones',
                  estimatedDays: 6,
                  price: 50,
                  requirements: [
                    'Memorial y fotocopia',
                    'Formulario de solvencia',
                    'Fotocopia de cedula de identidad o pasaporte',
                    'Pago por certificados de calificacion',
                    'Pago por programas analiticos',
                    'Una hoja de tramites 20bs.',
                    'Una carpeta academica 10bs.',
                    'Adjuntar fotocopia de factura'
                  ],
                )
              ],
            ),
          ]),
        );

        await tester.pumpApp(bloc: procedureBloc);
        await tester.pump();

        expect(find.byType(ProcedureCard), findsOneWidget);
      },
    );
  });
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required ProceduresBloc bloc,
  }) {
    return pumpWidget(
      BlocProvider<ProceduresBloc>.value(
        value: bloc,
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: ProceduresView()),
        ),
      ),
    );
  }
}
