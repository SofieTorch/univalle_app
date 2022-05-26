import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/authentication/bloc/authentication_bloc.dart';
import 'package:univalle_app/data/repositories/authentication_repository.dart';

void main() {
  group('AuthenticationEvent props', () {
    test('AuthenticationStatusChanged props are not empty', () {
      expect(
        const AuthenticationStatusChanged(AuthenticationStatus.unauthenticated)
            .props,
        isNotEmpty,
      );
    });

    test('AuthenticationLogoutRequested props are empty', () {
      expect(
        AuthenticationLogoutRequested().props,
        isEmpty,
      );
    });

    test('AuthenticationRequested props are empty', () {
      expect(
        AuthenticationRequested().props,
        isEmpty,
      );
    });
  });
}
