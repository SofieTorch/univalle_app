import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:univalle_app/exceptions/sign_in_failure.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/sign_in/sign_in.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  _getErrorMessage(state.error!, l10n),
                ),
              ),
            );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.signInStudentCodeLabel),
          _StudentCodeInput(),
          const Padding(padding: EdgeInsets.all(6)),
          Text(l10n.signInPasswordLabel),
          _PasswordInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _LoginButton(),
        ],
      ),
    );
  }

  String _getErrorMessage(SignInFailure failure, AppLocalizations l10n) {
    if (failure is UserLockedFailure) {
      return l10n.authUserBlockedFailure;
    } else if (failure is UserDoesNotExistFailure) {
      return l10n.authUserDoesNotExistFailure;
    } else if (failure is IncorrectPasswordFailure) {
      return l10n.authIncorrectPasswordFailure;
    } else {
      return l10n.authUnexpectedFailure;
    }
  }
}

class _StudentCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.studentCode != current.studentCode,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_studentCodeInput_textField'),
          onChanged: (studentCode) => context
              .read<SignInBloc>()
              .add(SignInStudentCodeChanged(studentCode)),
          decoration: InputDecoration(
            errorText: state.studentCode.invalid
                ? l10n.studentCodeInputEmptyError
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          keyboardType: TextInputType.number,
          onChanged: (password) =>
              context.read<SignInBloc>().add(SignInPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            errorText:
                state.password.invalid ? l10n.passwordInputEmptyError : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .read<SignInBloc>()
                              .add(const SignInSubmitted());
                        }
                      : null,
                  child: Text(l10n.signInButtonText),
                ),
              );
      },
    );
  }
}
