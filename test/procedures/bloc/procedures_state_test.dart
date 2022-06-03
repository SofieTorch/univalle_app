import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/procedures/bloc/procedures_bloc.dart';

void main() {
  test('ProceduresState.copyWith() empty clones correctly ', () {
    const state = ProceduresState();
    final copy = state.copyWith();
    expect(state, equals(copy));
  });
}
