import 'package:formz/formz.dart';

/// The possible validation errors that
/// the password text field can have.
enum PasswordValidationError { empty }

/// Represents the password text field, containing its value
/// and whether it's valid or not.
///
/// /// It's validation errors are some value of [PasswordValidationError].
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : PasswordValidationError.empty;
  }
}
