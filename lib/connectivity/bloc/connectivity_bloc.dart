import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_event.dart';

enum ConnectivityState {
  initial,
  connected,
  disconnected,
}

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc(this._connectivity) : super(ConnectivityState.initial) {
    _connectivitySubscription = _connectivity
      .onConnectivityChanged
      .listen(_onConnectivityChanged);

    on<ConnectivityLost>(_onConnectivityLost);
    on<ConnectivityRetrieved>(_onConnectivityRetrieved);
  }

  final Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

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

  void _onConnectivityChanged(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      add(const ConnectivityLost());
    } else {
      add(const ConnectivityRetrieved());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
