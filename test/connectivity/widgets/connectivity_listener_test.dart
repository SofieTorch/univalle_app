import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univalle_app/connectivity/connectivity.dart';
import 'package:univalle_app/counter/counter.dart';
import 'package:univalle_app/l10n/l10n.dart';

class MockConnectivityBloc
    extends MockBloc<ConnectivityEvent, ConnectivityState>
    implements ConnectivityBloc {}

void main() {
  late MockConnectivityBloc connectivityBloc;
  const snackBarConnectionAvailableText = '¡Conexión recuperada!';

  setUp(() {
    connectivityBloc = MockConnectivityBloc();
    when(() => connectivityBloc.state).thenReturn(ConnectivityState.initial);
  });
  testWidgets(
    '''
      connectivity listener displays connectivity lost dialog
      when there is no connectivity.
    ''',
    (tester) async {
      whenListen(
        connectivityBloc,
        Stream<ConnectivityState>.fromIterable([
          ConnectivityState.loading,
          ConnectivityState.disconnected,
        ]),
      );

      await tester.pumpApp(
        widget: const ConnectivityListener(child: CounterPage()),
        bloc: connectivityBloc,
      );

      await tester.pump();
      expect(find.byType(ConnectivityLostDialog), findsOneWidget);
      expect(find.text(snackBarConnectionAvailableText), findsNothing);
    },
  );

  testWidgets(
    '''
      connectivity listener does not display anything
      when there is connectivity.
    ''',
    (tester) async {
      whenListen(
        connectivityBloc,
        Stream<ConnectivityState>.fromIterable([
          ConnectivityState.loading,
          ConnectivityState.connected,
        ]),
      );

      await tester.pumpApp(
        widget: const ConnectivityListener(child: CounterPage()),
        bloc: connectivityBloc,
      );

      await tester.pump();
      expect(find.byType(ConnectivityLostDialog), findsNothing);
      expect(find.text(snackBarConnectionAvailableText), findsNothing);
    },
  );

  testWidgets(
    '''
      connectivity listener closes the connectivity lost dialog
      and shows an informative snackbar
      when connection is retrieved after connection was lost.
    ''',
    (tester) async {
      whenListen(
        connectivityBloc,
        Stream<ConnectivityState>.fromIterable([
          ConnectivityState.loading,
          ConnectivityState.disconnected,
          ConnectivityState.connected,
        ]),
      );

      await tester.pumpApp(
        widget: const ConnectivityListener(child: CounterPage()),
        bloc: connectivityBloc,
      );

      await tester.pump();
      await tester.pump(const Duration(seconds: 3));

      expect(find.byType(ConnectivityLostDialog), findsNothing);
      expect(find.text(snackBarConnectionAvailableText), findsOneWidget);
    },
  );
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    required Widget widget,
    required ConnectivityBloc bloc,
  }) {
    return pumpWidget(
      BlocProvider<ConnectivityBloc>.value(
        value: bloc..add(const ConnectivityRequested()),
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
