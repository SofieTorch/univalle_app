import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/procedures_provider.dart';
import 'package:univalle_app/data/repositories/procedures_repository.dart';
import 'package:univalle_app/models/procedure.dart';

class MockProcedureProvider extends Mock implements ProceduresProvider {}

class MockResponse extends Mock implements Response {}

void main() {
  group('ProcedureRepository', () {
    late ProcedureRepository repository;
    late MockProcedureProvider mockProcedureProvider;

    setUp(() {
      mockProcedureProvider = MockProcedureProvider();
      repository = ProcedureRepository(
        proceduresProvider: mockProcedureProvider,
      );
    });
    test(
      '''
      getProcedure() request returns Procedure successfully.
      ''',
      () {
        const procedureJson = '''
          {
            "proceduresTypes": [
              {
                "id": 405,
                "name": "Certificado de calificaciones",
                "estimatedDays": 6,
                "needsInvoice": true,
                "price": 50,
                "requirements": [
                  "Memorial y fotocopia",
                  "Formulario de solvencia",
                  "Fotocopia de cedula de identidad o pasaporte",
                  "Pago por certificados de calificacion",
                  "Pago por programas analiticos",
                  "Una hoja de tramites 20bs.",
                  "Una carpeta academica 10bs.",
                  "Adjuntar fotocopia de factura"
                ]
              }
            ]
          }
        ''';
        //Revisar
        const procedure = Procedure(
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
        );
        when(() => mockProcedureProvider.requestProcedure()).thenAnswer(
          (_) => Future<Response>(() => Response(procedureJson, 200)),
        );

        final future = repository.getProcedure();
        expect(future, completion(equals([procedure])));
      },
    );
    test(
      '''
      getProcedure() request throws an error
      when respose code is not 200.
      ''',
      () {
        when(() => mockProcedureProvider.requestProcedure()).thenAnswer(
          (_) => Future<Response>(() => Response('', 500)),
        );

        expect(repository.getProcedure(), throwsException);
      },
    );
  });
}
