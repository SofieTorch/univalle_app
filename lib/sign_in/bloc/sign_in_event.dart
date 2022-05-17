part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

/// Triggered when the student code text field values's
/// has changed.
class SignInStudentCodeChanged extends SignInEvent {
  const SignInStudentCodeChanged(this.studentCode);

  final String studentCode;

  @override
  List<Object> get props => [studentCode];
}

/// Triggered when the password text field values's
/// has changed.
class SignInPasswordChanged extends SignInEvent {
  const SignInPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

/// Triggered when the sign-in form has been submited.
class SignInSubmitted extends SignInEvent {
  const SignInSubmitted();

  @override
  List<Object?> get props => [];
}
