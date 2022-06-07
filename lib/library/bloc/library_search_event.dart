part of 'library_search_bloc.dart';

abstract class LibrarySearchEvent extends Equatable {
  const LibrarySearchEvent();
}

class SearchTextChanged extends LibrarySearchEvent {
  const SearchTextChanged(this.searchText);

  final String searchText;

  @override
  List<Object> get props => [searchText];
}

class SearchSubmitted extends LibrarySearchEvent {
  const SearchSubmitted();

  @override
  List<Object?> get props => [];
}
