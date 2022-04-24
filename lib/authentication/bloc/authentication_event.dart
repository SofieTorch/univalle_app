part of 'authentication_bloc.dart';

/// Base class for events from [AuthenticationBloc].
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// Triggered when the [AuthenticationStatus] has changed.
/// Contains the new [AuthenticationStatus].
class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  /// The new authentication status.
  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

/// Triggered when the user logs out.
class AuthenticationLogoutRequested extends AuthenticationEvent {}

/// Triggered when the initialization of authentication
/// verification and repository has been requested.
class AuthenticationRequested extends AuthenticationEvent {}
