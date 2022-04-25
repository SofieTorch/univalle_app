import 'package:formz/formz.dart';

enum StudentCodeValidationError { empty }

class StudentCode extends FormzInput<String, StudentCodeValidationError> {
  const StudentCode.pure() : super.pure('');
  const StudentCode.dirty([String value = '']) : super.dirty(value);

  @override
  StudentCodeValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : StudentCodeValidationError.empty;
  }
}
