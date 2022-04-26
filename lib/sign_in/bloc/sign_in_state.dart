part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.status = FormzStatus.pure,
    this.studentCode = const StudentCode.pure(),
    this.password = const Password.pure(),
    this.error,
  });

  final FormzStatus status;
  final StudentCode studentCode;
  final Password password;
  final SignInFailure? error;

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
