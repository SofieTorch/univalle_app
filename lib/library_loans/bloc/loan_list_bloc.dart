import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/library_repository.dart';
import 'package:univalle_app/models/loan.dart';

part 'loan_list_event.dart';
part 'loan_list_state.dart';

class LoanListBloc extends Bloc<LoanListEvent, LoanListState> {
  LoanListBloc({
    required LibraryRepository libraryRepository,
  })  : _repository = libraryRepository,
        super(const LoanListState()) {
    on<LoanListRequested>(_onLoanListRequested);
  }

  final LibraryRepository _repository;

  Future<void> _onLoanListRequested(
    LoanListRequested event,
    Emitter<LoanListState> emit,
  ) async {
    emit(state.copyWith(status: LoanListRequestStatus.loading));

    try {
      final loans = await _repository.getLoans();
      emit(
        state.copyWith(
          status: LoanListRequestStatus.success,
          loans: loans,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoanListRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
