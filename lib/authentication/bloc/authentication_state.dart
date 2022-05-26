part of 'authentication_bloc.dart';

/// State emitted by [AuthenticationBloc].
///
/// Contains the current [User] and [AuthenticationStatus].
/// Three named constructors are exposed: unknown, unauthenticated
/// and authenticated; to make it easier to work with.
class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  /// The default state which indicates that the bloc does not yet know
  /// whether the current user is authenticated or not.
  const AuthenticationState.unknown() : this._();

  /// The state which indicates that the user is current authenticated.
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  /// The state which indicates that the user is current not authenticated.
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  /// The current authentication status.
  final AuthenticationStatus status;

  /// The current authenticated user.
  final User user;

  @override
  List<Object> get props => [status, user];
}
