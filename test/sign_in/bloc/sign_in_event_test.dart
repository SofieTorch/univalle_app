import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/sign_in/bloc/sign_in_bloc.dart';

void main() {
  group('SignInEvent testing', () {
    test('SignInStudentCodeChanged props are not empty', () {
      expect(const SignInStudentCodeChanged('codeTest').props, isNotEmpty);
    });

    test('SignInPasswordChanged props are not empty', () {
      expect(const SignInPasswordChanged('passwordTest').props, isNotEmpty);
    });

    test('SignInSubmitted props are empty', () {
      expect(const SignInSubmitted().props, isEmpty);
    });
  });
}
