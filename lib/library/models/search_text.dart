import 'package:formz/formz.dart';

/// The possible validation errors that
/// the search text field can have.
enum SearchTextValidationError { empty }

/// Represents the search text field, containing its value
/// and whether it's valid or not.
///
/// It's validation errors are some value of [SearchTextValidationError].
class SearchText extends FormzInput<String, SearchTextValidationError> {
  const SearchText.pure() : super.pure('');
  const SearchText.dirty([String value = '']) : super.dirty(value);

  @override
  SearchTextValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? null
        : SearchTextValidationError.empty;
  }
}
