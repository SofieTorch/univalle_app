import 'package:formz/formz.dart';

/// The possible validation errors that
/// the student code text field can have.
enum StudentCodeValidationError { empty }

/// Represents the student code text field, containing its value
/// and whether it's valid or not.
///
/// It's validation errors are some value of [StudentCodeValidationError].
class StudentCode extends FormzInput<String, StudentCodeValidationError> {
  const StudentCode.pure() : super.pure('');
  const StudentCode.dirty([String value = '']) : super.dirty(value);

  @override
  StudentCodeValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : StudentCodeValidationError.empty;
  }
}
