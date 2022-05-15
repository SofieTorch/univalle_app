import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/exceptions/sign_in_failure.dart';

void main() {
  group('SignInFailure.fromCode factory', () {
    test('Default message indicates the error is unknown', () {
      expect(const SignInFailure().message, contains('unknown'));
    });

    test('Builds [UserLockedFailure] when code is 423.', () {
      expect(SignInFailure.fromCode(423), UserLockedFailure());
    });

    test('Builds [UserDoesNotExistFailure] when code is 404.', () {
      expect(SignInFailure.fromCode(404), UserDoesNotExistFailure());
    });

    test('Builds [IncorrectPasswordFailure] when code is 401.', () {
      expect(SignInFailure.fromCode(401), IncorrectPasswordFailure());
    });
  });
}
