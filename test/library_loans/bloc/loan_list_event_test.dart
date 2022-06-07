import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/library_loans/bloc/loan_list_bloc.dart';

void main() {
  group('LoanListEvent', () {
    test('LoanListRequested.props are empty', () {
      expect(LoanListRequested().props, isEmpty);
    });
  });
}
