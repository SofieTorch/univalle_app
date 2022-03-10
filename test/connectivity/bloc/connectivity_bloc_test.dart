import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:univalle_app/connectivity/connectivity.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity mockConnectivity;
  group('Connectivity bloc', () {
    setUp(() {
      mockConnectivity = MockConnectivity();

      when(() => mockConnectivity.onConnectivityChanged).thenAnswer(
        (_) => Stream<ConnectivityResult>.fromIterable([]),
      );
    });

    test('Initial state is [ConnectivityState.initial].', () {
      when(mockConnectivity.checkConnectivity)
          .thenAnswer((_) async => ConnectivityResult.none);
      expect(
        ConnectivityBloc(mockConnectivity).state,
        ConnectivityState.initial,
      );
    });

    blocTest<ConnectivityBloc, ConnectivityState>(
      '''
        emits [loading, disconnected] when ConnectivityRequested is added
        and checkConnectivity result is none.
      ''',
      build: () => ConnectivityBloc(mockConnectivity),
      act: (bloc) {
        when(mockConnectivity.checkConnectivity)
            .thenAnswer((_) async => ConnectivityResult.none);

        bloc.add(const ConnectivityRequested());
      },
      expect: () => const <ConnectivityState>[
        ConnectivityState.loading,
        ConnectivityState.disconnected,
      ],
    );

    blocTest<ConnectivityBloc, ConnectivityState>(
      'emits [connected] when [ConnectivityRetrieved] is added.',
      build: () => ConnectivityBloc(mockConnectivity),
      act: (bloc) => bloc.add(const ConnectivityRetrieved()),
      expect: () => const <ConnectivityState>[ConnectivityState.connected],
    );

    blocTest<ConnectivityBloc, ConnectivityState>(
      'emits [disconnected] when [ConnectivityLost] is added.',
      build: () => ConnectivityBloc(mockConnectivity),
      act: (bloc) => bloc.add(const ConnectivityRetrieved()),
      expect: () => const <ConnectivityState>[ConnectivityState.connected],
    );

    blocTest<ConnectivityBloc, ConnectivityState>(
      'maps ConnectivityResult.none to [disconnected].',
      build: () => ConnectivityBloc(mockConnectivity),
      act: (bloc) {
        when(mockConnectivity.checkConnectivity)
            .thenAnswer((_) async => ConnectivityResult.wifi);
        when(() => mockConnectivity.onConnectivityChanged).thenAnswer(
          (_) => Stream<ConnectivityResult>.fromIterable([
            ConnectivityResult.none,
          ]),
        );

        bloc.add(const ConnectivityRequested());
      },
      expect: () => const <ConnectivityState>[
        ConnectivityState.loading,
        ConnectivityState.connected,
        ConnectivityState.disconnected,
      ],
    );

    blocTest<ConnectivityBloc, ConnectivityState>(
      '''
        maps any ConnectivityResult other than
        ConnectivityResult.none to [connected].
      ''',
      build: () => ConnectivityBloc(mockConnectivity),
      act: (bloc) {
        when(mockConnectivity.checkConnectivity)
            .thenAnswer((_) async => ConnectivityResult.none);
        when(() => mockConnectivity.onConnectivityChanged).thenAnswer(
          (_) => Stream<ConnectivityResult>.fromIterable([
            ConnectivityResult.wifi,
            ConnectivityResult.mobile,
            ConnectivityResult.bluetooth,
            ConnectivityResult.ethernet,
          ]),
        );

        bloc.add(const ConnectivityRequested());
      },
      expect: () => const <ConnectivityState>[
        ConnectivityState.loading,
        ConnectivityState.disconnected,
        ConnectivityState.connected,
      ],
    );
  });
}
