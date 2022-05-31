import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/subjects/bloc/subject_list_bloc.dart';

void main() {
  test('subject list event props are empty', () {
    final event = SubjectListRequested();
    expect(event.props, isEmpty);
  });
}
