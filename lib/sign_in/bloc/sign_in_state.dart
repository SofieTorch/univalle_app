part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.status = FormzStatus.pure,
    this.studentCode = const StudentCode.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final StudentCode studentCode;
  final Password password;

  SignInState copyWith({
    FormzStatus? status,
    StudentCode? studentCode,
    Password? password,
  }) {
    return SignInState(
      status: status ?? this.status,
      studentCode: studentCode ?? this.studentCode,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, studentCode, password];
}
