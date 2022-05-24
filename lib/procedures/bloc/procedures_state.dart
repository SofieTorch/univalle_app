part of 'procedures_bloc.dart';
enum ProcedureListRequestStatus { initial, loading, success, failure }
class ProceduresState extends Equatable {
  const ProceduresState({
    this.status = ProcedureListRequestStatus.initial,
    this.procedures = const<Procedure>[],
    this.errorMessage,
  });

  final ProcedureListRequestStatus status;
  final List<Procedure> procedures;
  final String? errorMessage;

  ProceduresState copyWith({
    ProcedureListRequestStatus? status,
    List<Procedure>? courses,
    String? errorMessage,
  }) {
    return ProceduresState(
      status: status ?? this.status,
      procedures: procedures ?? this.procedures,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [];
}
