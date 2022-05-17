import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:univalle_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:univalle_app/sign_in/models/models.dart';

void main() {
  testWidgets('SignInState.copyWith works correctly', (tester) async {
    const expected = SignInState(
      status: FormzStatus.valid,
    );
    const initial = SignInState(
      status: FormzStatus.valid,
      studentCode: StudentCode.dirty('test'),
    );
    expect(initial != expected, isTrue);

    final current = initial.copyWith(studentCode: const StudentCode.pure());
    expect(current, expected);
  });
}
