part of 'procedure_item_cubit.dart';

class ProcedureItemState extends Equatable {
  const ProcedureItemState({
    required this.procedure,
    this.showRequirements = false,
  });

  final Procedure procedure;
  final bool showRequirements;

  ProcedureItemState copyWith({
    required bool showRequirements,
  }) {
    return ProcedureItemState(
      procedure: procedure,
      showRequirements: showRequirements,
    );
  }

  @override
  List<Object> get props => [procedure, showRequirements];
}
