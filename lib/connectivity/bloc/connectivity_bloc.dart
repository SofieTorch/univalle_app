import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connectivity_event.dart';

/// Reflects internet connection check status.
enum ConnectivityState {
  initial,
  loading,
  connected,
  disconnected,
}

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc(this._connectivity) : super(ConnectivityState.initial) {
    on<ConnectivityRequested>(_onConnectivityRequested);
    on<ConnectivityLost>(_onConnectivityLost);
    on<ConnectivityRetrieved>(_onConnectivityRetrieved);
  }

  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

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
