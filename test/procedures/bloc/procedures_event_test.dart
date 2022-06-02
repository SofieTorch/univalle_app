import 'package:flutter_test/flutter_test.dart';
import 'package:univalle_app/procedures/bloc/procedures_bloc.dart';

void main() {
  test('Procedure requested props are empty', () {
    final event = ProcedureListRequested();
    expect(event.props, isEmpty);
  });
}
