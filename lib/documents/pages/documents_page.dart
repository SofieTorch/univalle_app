import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/documents_repository.dart';
import 'package:univalle_app/documents/documents.dart';
import 'package:univalle_app/l10n/l10n.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentListBloc>(
      create: (context) => DocumentListBloc(
        documentsRepository: DocumentsRepository(
          documentsProvider: DocumentsProvider(
            storageProvider: context.read<StorageProvider>(),
          ),
        ),
      )..add(const DocumentListRequested()),
      child: const DocumentsView(),
    );
  }
}

class DocumentsView extends StatelessWidget {
  const DocumentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.documentsPageAppBar),
      ),
      body: BlocBuilder<DocumentListBloc, DocumentListState>(
        builder: (context, state) {
          if (state.status == DocumentListRequestStatus.failure) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          if (state.status == DocumentListRequestStatus.success) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.documents.length,
              itemBuilder: (_, index) =>
                  DocumentListItem(state.documents[index]),
              separatorBuilder: (_, index) => const SizedBox(height: 16),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
