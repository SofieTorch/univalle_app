import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/models/models.dart';

part 'grade_list_event.dart';
part 'grade_list_state.dart';

/// Manages the logic related to grades,
/// retrieving them when [GradeListRequested] is added
/// and updating the [GradeListState.selectedManagement].
class GradeListBloc extends Bloc<GradeListEvent, GradeListState> {
  GradeListBloc({
    required GradesRepository gradesRepository,
  })  : _repository = gradesRepository,
        super(const GradeListState()) {
    on<GradeListRequested>(_onGradeListRequested);
    on<ManagementChanged>(_onManagementChanged);
  }
  final GradesRepository _repository;

  /// Sends the request to retrieve [GradeListState.grades],
  /// through [GradesRepository].
  ///
  /// Emits a new state with the retrieved grades is the request
  /// is successful, otherwise emits a new state with an error message.
  Future<void> _onGradeListRequested(
    GradeListRequested event,
    Emitter<GradeListState> emit,
  ) async {
    emit(state.copyWith(status: GradeListRequestStatus.loading));
    try {
      final grades = await _repository.getGrades();
      emit(
        state.copyWith(
          status: GradeListRequestStatus.success,
          grades: grades,
          selectedManagement: grades.keys.toList()[0],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GradeListRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Emits a new state with
  /// [GradeListState.selectedManagement] updated.
  void _onManagementChanged(
    ManagementChanged event,
    Emitter<GradeListState> emit,
  ) {
    emit(state.copyWith(selectedManagement: event.managementSelected));
  }
}
