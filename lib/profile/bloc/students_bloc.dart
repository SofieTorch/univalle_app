import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/student_repository.dart';
import 'package:univalle_app/models/models.dart';
part 'students_event.dart';
part 'students_state.dart';



class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc({required StudentRepository studentRepository})
    : _repository = studentRepository,
    super(const StudentsState()) {
    on<StudentsRequested>(_onStudentsRequested);
  }
  final StudentRepository _repository;
  Future<void> _onStudentsRequested(
    StudentsRequested event,
    Emitter<StudentsState> emit,
  ) async {
    emit(state.copyWith(status: StudentRequestStatus.loading));
    try {
      final student = await _repository.getStudent();
      emit(
          state.copyWith(
          status: StudentRequestStatus.success,
          student: student,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StudentRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}



