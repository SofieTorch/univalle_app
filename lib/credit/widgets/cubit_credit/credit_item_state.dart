import 'package:equatable/equatable.dart';

class CreditItemState extends Equatable {
  const CreditItemState({
    this.showCredit = false,
  });

  final bool showCredit;

  CreditItemState copyWith({
    required bool showCredit,
  }) {
    return CreditItemState(
      showCredit: showCredit,
    );
  }

  @override
  List<Object> get props => [showCredit];
}
