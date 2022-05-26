import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univalle_app/data/providers/storage_provider.dart';

void main() {
  group('Storage Provider testing', () {
    test('Saves the code correctly', () async {
      SharedPreferences.setMockInitialValues({});
      final storageProvider = StorageProvider(
        prefs: await SharedPreferences.getInstance(),
      );

      await storageProvider.setCode('codeTest');
      expect(storageProvider.code, 'codeTest');
    });

    test('Saves the token correctly', () async {
      SharedPreferences.setMockInitialValues({'code': 'codeTest'});
      final storageProvider = StorageProvider(
        prefs: await SharedPreferences.getInstance(),
      );

      await storageProvider.setToken('tokenTest');
      final expected = base64Encode(utf8.encode('codeTest:tokenTest'));
      expect(storageProvider.token, expected);
    });

    test('Removes the code correctly', () async {
      SharedPreferences.setMockInitialValues({'code': 'codeTest'});
      final storageProvider = StorageProvider(
        prefs: await SharedPreferences.getInstance(),
      );

      await storageProvider.removeCode();
      expect(storageProvider.code, '');
    });

    test('Removes the token correctly', () async {
      SharedPreferences.setMockInitialValues({'token': 'tokenTest'});
      final storageProvider = StorageProvider(
        prefs: await SharedPreferences.getInstance(),
      );

      await storageProvider.removeToken();
      expect(storageProvider.token, '');
    });
  });
}
