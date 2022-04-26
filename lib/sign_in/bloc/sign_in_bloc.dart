import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:univalle_app/data/repositories/authentication_repository.dart';
import 'package:univalle_app/exceptions/sign_in_failure.dart';
import 'package:univalle_app/sign_in/models/models.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required AuthenticationRepository authRepository})
      : _authenticationRepository = authRepository,
        super(const SignInState()) {
    on<SignInStudentCodeChanged>(_onStudentCodeChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onStudentCodeChanged(
    SignInStudentCodeChanged event,
    Emitter<SignInState> emit,
  ) {
    final studentCode = StudentCode.dirty(event.studentCode);
    emit(
      state.copyWith(
        studentCode: studentCode,
        status: Formz.validate([state.password, studentCode]),
      ),
    );
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.studentCode]),
      ),
    );
  }

  Future<void> _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _authenticationRepository.signIn(
        code: state.studentCode.value.toUpperCase(),
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInFailure catch (e) {
      emit(
        state.copyWith(
          error: e,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          error: const SignInFailure(),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
