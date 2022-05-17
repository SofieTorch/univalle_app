import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/models/models.dart';

void main() {
  group('User model', () {
    late User user;

    test('User.empty works correctly', () {
      user = User.empty;
      expect(user.isEmpty, true);
      expect(user.isNotEmpty, false);
    });
  });
}
