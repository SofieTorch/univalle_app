part of 'sign_in_bloc.dart';

/// State emitted by [SignInBloc].
///
/// Contains the sign-in credentials and its status
/// ([FormzStatus]).
class SignInState extends Equatable {
  const SignInState({
    this.status = FormzStatus.pure,
    this.studentCode = const StudentCode.pure(),
    this.password = const Password.pure(),
    this.error,
  });

  /// Status of the credentials and its submission.
  final FormzStatus status;

  /// In case the sig-in request failed, this contains
  /// the exception throwned.
  final SignInFailure? error;

  final StudentCode studentCode;
  final Password password;

  SignInState copyWith({
    FormzStatus? status,
    StudentCode? studentCode,
    Password? password,
    SignInFailure? error,
  }) {
    return SignInState(
      status: status ?? this.status,
      studentCode: studentCode ?? this.studentCode,
      password: password ?? this.password,
      error: error,
    );
  }

  @override
  List<Object> get props => [status, studentCode, password];
}
