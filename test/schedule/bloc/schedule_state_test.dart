import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/schedule/bloc/schedule_bloc.dart';

void main() {
  test('ScheduleState.copyWith() empty clones correctly ', () {
    const state = ScheduleState();
    final copy = state.copyWith();
    expect(state, equals(copy));
  });
}
