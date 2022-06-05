part of 'document_list_bloc.dart';

enum DocumentListRequestStatus { initial, loading, success, failure }

class DocumentListState extends Equatable {
  const DocumentListState({
    this.status = DocumentListRequestStatus.initial,
    this.documents = const [],
    this.errorMessage = '',
  });

  final DocumentListRequestStatus status;
  final List<Document> documents;
  final String errorMessage;

  DocumentListState copyWith({
    DocumentListRequestStatus? status,
    List<Document>? documents,
    String? errorMessage,
  }) {
    return DocumentListState(
      status: status ?? this.status,
      documents: documents ?? this.documents,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, documents, errorMessage];
}

class DocumentListInitial extends DocumentListState {}
