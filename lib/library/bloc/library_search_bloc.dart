import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:univalle_app/data/repositories/library_repository.dart';
import 'package:univalle_app/library/library.dart';
import 'package:univalle_app/models/book.dart';

part 'library_search_event.dart';
part 'library_search_state.dart';

class LibrarySearchBloc extends Bloc<LibrarySearchEvent, LibrarySearchState> {
  LibrarySearchBloc({
    required LibraryRepository libraryRepository,
  })  : _repository = libraryRepository,
        super(LibrarySearchInitial()) {
    on<SearchTextChanged>(_onSearchTextChanged);
    on<SearchSubmitted>(_onSearchSubmitted);
  }

  final LibraryRepository _repository;

  void _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<LibrarySearchState> emit,
  ) {
    final searchText = SearchText.dirty(event.searchText);
    emit(
      state.copyWith(
        searchText: searchText,
        status: Formz.validate([searchText]),
      ),
    );
  }

  Future<void> _onSearchSubmitted(
    SearchSubmitted event,
    Emitter<LibrarySearchState> emit,
  ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      final books = await _repository.searchBook(state.searchText.value);
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          searchResults: books,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
