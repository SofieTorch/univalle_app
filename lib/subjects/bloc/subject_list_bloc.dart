import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/repositories.dart';
import 'package:univalle_app/models/models.dart';

part 'subject_list_event.dart';
part 'subject_list_state.dart';

/// Manages the subjects list, making the request and
/// verifying its status.
///
/// Uses [SubjectsRepository] to make the request.
class SubjectListBloc extends Bloc<SubjectListEvent, SubjectListState> {
  SubjectListBloc({required SubjectsRepository subjectsRepository})
      : _repository = subjectsRepository,
        super(const SubjectListState()) {
    on<SubjectListRequested>(_onSubjectListRequested);
  }

  final SubjectsRepository _repository;

  /// Sends a http request to retrieve current
  /// student courses/subjects.
  Future<void> _onSubjectListRequested(
    SubjectListRequested event,
    Emitter<SubjectListState> emit,
  ) async {
    emit(state.copyWith(status: SubjectListRequestStatus.loading));
    try {
      final courses = await _repository.getCurrentCourses();
      emit(
        state.copyWith(
          status: SubjectListRequestStatus.success,
          courses: courses,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SubjectListRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
