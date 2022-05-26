import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/subjects/bloc/subject_list_bloc.dart';

void main() {
  test('SubjectListState.copyWith() empty clones correctly', () {
    const state = SubjectListState();
    final copy = state.copyWith();
    expect(state, equals(copy));
  });
}
