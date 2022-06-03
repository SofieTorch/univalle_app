import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/data/providers/procedures_provider.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/environment.dart';

class MockResponse extends Mock implements Response {}

class MockHttpProvider extends Mock implements HttpProvider {}

void main() {
  group('ProceduresProvider', () {
    late ProceduresProvider proceduresProvider;
    late MockHttpProvider mockHttpProvider;
    late MockResponse mockResponse;
    setUp(() {
      mockHttpProvider = MockHttpProvider();
      mockResponse = MockResponse();

      proceduresProvider = ProceduresProvider(
        httpProvider: mockHttpProvider,
      );
    });
    //Pendiente test
    test('''
      requestProcedure() requests procedure and
      returns Response successfully.
      ''', () {
      final endpoint = Uri.https(Environment.host, '/procedures');
      when(() => mockHttpProvider.get(endpoint))
          .thenAnswer((_) => Future<Response>(() => mockResponse));

      final future = proceduresProvider.requestProcedure();

      expect(future, completion(mockResponse));
      verify(() => mockHttpProvider.get(endpoint)).called(1);
    });
  });
}
