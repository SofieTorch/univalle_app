import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/schedule/schedule.dart';

void main() {
  test('Schedule requested props are empty', () {
    const event = ScheduleRequested();
    expect(event.props, isEmpty);
  });
}
