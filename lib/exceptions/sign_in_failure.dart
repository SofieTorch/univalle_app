import 'package:equatable/equatable.dart';

/// Thrown during the log in/sign in process if a failure occurs.
class SignInFailure extends Equatable implements Exception {
  const SignInFailure() : _message = 'An unknown exception occurred.';

  /// Create an authentication error message
  /// from an http response code.
  factory SignInFailure.fromCode(int code) {
    switch (code) {
      case 423:
        return UserLockedFailure();
      case 404:
        return UserDoesNotExistFailure();
      case 401:
        return IncorrectPasswordFailure();
      default:
        return const SignInFailure();
    }
  }

  final String _message;

  /// The associated error message.
  String get message => _message;

  @override
  List<Object?> get props => [message];
}

/// Thrown when the user trying to authenticate is blocked.
class UserLockedFailure extends SignInFailure {
  @override
  String get message => 'This user has been locked.';
}

/// Thrown when the user trying to authenticate does not exist.
class UserDoesNotExistFailure extends SignInFailure {
  @override
  String get message => 'The student code does not exist.';
}

/// Thrown when the user trying to authenticate
/// entered an incorrect password.
class IncorrectPasswordFailure extends SignInFailure {
  @override
  String get message => 'Incorrect password.';
}
