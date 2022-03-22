import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connectivity_event.dart';

/// Reflects internet connection check status.
/// Emitted by [ConnectivityBloc].
enum ConnectivityState {
  /// Initial state, only emitted when [ConnectivityBloc] is initialized.
  initial,

  /// Emitted when the internet connection check is loading.
  loading,

  /// Reflects an  available internet connection.
  connected,

  /// Reflects an  unavailable internet connection.
  disconnected,
}

/// Manages the internet connection status, using the [Connectivity] library.
/// Recieves [ConnectivityEvent] and emits [ConnectivityState].
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc(this._connectivity) : super(ConnectivityState.initial) {
    on<ConnectivityRequested>(_onConnectivityRequested);
    on<ConnectivityLost>(_onConnectivityLost);
    on<ConnectivityRetrieved>(_onConnectivityRetrieved);
  }

  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  /// Verifies the internet connection for first time
  /// and initializes the suscription to [Connectivity].
  Future<void> _onConnectivityRequested(
    ConnectivityRequested event,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(ConnectivityState.loading);
    final result = await _connectivity.checkConnectivity();
    _mapToState(result);

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_mapToState);
  }

  void _onConnectivityLost(
    ConnectivityLost event,
    Emitter<ConnectivityState> emit,
  ) {
    emit(ConnectivityState.disconnected);
  }

  void _onConnectivityRetrieved(
    ConnectivityRetrieved event,
    Emitter<ConnectivityState> emit,
  ) {
    emit(ConnectivityState.connected);
  }

  /// Adds [ConnectivityLost] or [ConnectivityRetrieved] events
  /// based on the [ConnectivityResult] received.
  void _mapToState(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      add(const ConnectivityLost());
    } else {
      add(const ConnectivityRetrieved());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
