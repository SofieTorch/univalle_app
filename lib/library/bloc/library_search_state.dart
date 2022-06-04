part of 'library_search_bloc.dart';

class LibrarySearchState extends Equatable {
  const LibrarySearchState({
    this.status = FormzStatus.pure,
    this.searchText = const SearchText.pure(),
    this.searchResults = const [],
    this.errorMessage = '',
  });

  final FormzStatus status;
  final List<Book> searchResults;
  final SearchText searchText;
  final String errorMessage;

  LibrarySearchState copyWith({
    FormzStatus? status,
    SearchText? searchText,
    List<Book>? searchResults,
    String? errorMessage,
  }) {
    return LibrarySearchState(
      status: status ?? this.status,
      searchText: searchText ?? this.searchText,
      searchResults: searchResults ?? this.searchResults,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, searchResults, searchText, errorMessage];
}

class LibrarySearchInitial extends LibrarySearchState {}
