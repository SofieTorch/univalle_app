import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/library_loans/bloc/loan_list_bloc.dart';

void main() {
  group('LoanListState', () {
    test(
      '.copyWith() method clones with the current status when status is null',
      () {
        const state = LoanListState();
        final copy = state.copyWith();
        expect(state, equals(copy));
      },
    );
  });
}
