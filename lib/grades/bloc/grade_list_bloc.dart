import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/models/models.dart';

part 'grade_list_event.dart';
part 'grade_list_state.dart';

class GradeListBloc extends Bloc<GradeListEvent, GradeListState> {
  GradeListBloc({
    required GradesRepository gradesRepository,
  })  : _repository = gradesRepository,
        super(const GradeListState()) {
    on<GradeListRequested>(_onGradeListRequested);
  }
  final GradesRepository _repository;

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
}
