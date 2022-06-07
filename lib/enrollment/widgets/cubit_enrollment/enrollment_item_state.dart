import 'package:equatable/equatable.dart';

class EnrollmentItemState extends Equatable {
  const EnrollmentItemState({
    this.showEnrollment = false,
  });

  final bool showEnrollment;

  EnrollmentItemState copyWith({
    required bool showEnrollment,
  }) {
    return EnrollmentItemState(
      showEnrollment: showEnrollment,
    );
  }

  @override
  List<Object> get props => [showEnrollment];
}
