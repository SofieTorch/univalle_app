import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/enrollment/widgets/cubit_enrollment/enrollment_item_state.dart';

class EnrollmentItemCubit extends Cubit<EnrollmentItemState> {
  EnrollmentItemCubit() : super(const EnrollmentItemState());

  void changeRequirementsVisibility() {
    emit(state.copyWith(showEnrollment: !state.showEnrollment));
  }
}
