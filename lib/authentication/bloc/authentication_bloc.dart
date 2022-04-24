import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/authentication_repository.dart';
import 'package:univalle_app/models/models.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// Manages the authentication state of the application which
/// is used to determine things like whether or not to start
/// the user at a login page or a home page.
///
/// Requires an [AuthenticationRequested] event to be initialized.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationRequested>(_onAuthenticationRequested);
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  final AuthenticationRepository _authRepository;
  late StreamSubscription<AuthenticationStatus> _authStatusSubscription;

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    _authRepository.dispose();
    return super.close();
  }

  /// Subscribes to the [AuthenticationStatus] stream from the
  /// [AuthenticationRepository] and adds an [AuthenticationStatusChanged]
  /// event internally to process changes in the authentication status.
  Future<void> _onAuthenticationRequested(
    AuthenticationRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    final user = await _authRepository.currentUser;
    emit(
      user.isNotEmpty
          ? AuthenticationState.authenticated(user)
          : const AuthenticationState.unauthenticated(),
    );

    _authStatusSubscription = _authRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  /// Process the new [AuthenticationStatus] and emits
  /// wheter an user is authenticated or not based on it.
  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());

      case AuthenticationStatus.authenticated:
        final user = await _authRepository.currentUser;
        return emit(
          user.isNotEmpty
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );

      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  /// Requests the log out of the current authenticated user.
  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authRepository.logOut();
  }
}
