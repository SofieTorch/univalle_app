import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:univalle_app/data/repositories/documents_repository.dart';
import 'package:univalle_app/models/document.dart';

part 'document_list_event.dart';
part 'document_list_state.dart';

class DocumentListBloc extends Bloc<DocumentListEvent, DocumentListState> {
  DocumentListBloc({
    required DocumentsRepository documentsRepository,
  })  : _repository = documentsRepository,
        super(DocumentListInitial()) {
    on<DocumentListRequested>(_onDocumentListRequested);
  }

  final DocumentsRepository _repository;

  Future<void> _onDocumentListRequested(
    DocumentListRequested event,
    Emitter<DocumentListState> emit,
  ) async {
    emit(state.copyWith(status: DocumentListRequestStatus.loading));

    try {
      final documents = await _repository.getDocuments();
      emit(
        state.copyWith(
          status: DocumentListRequestStatus.success,
          documents: documents,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DocumentListRequestStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
