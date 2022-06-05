part of 'document_list_bloc.dart';

abstract class DocumentListEvent extends Equatable {
  const DocumentListEvent();
}

class DocumentListRequested extends DocumentListEvent {
  const DocumentListRequested();

  @override
  List<Object> get props => [];
}
