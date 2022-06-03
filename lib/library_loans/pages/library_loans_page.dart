import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/library_repository.dart';
import 'package:univalle_app/library_loans/library_loans.dart';

class LibraryLoansPage extends StatelessWidget {
  const LibraryLoansPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoanListBloc(
        libraryRepository: LibraryRepository(
          libraryProvider: LibraryProvider(
            storageProvider: context.read<StorageProvider>(),
          ),
        ),
      )..add(LoanListRequested()),
      child: const LibraryLoansView(),
    );
  }
}

class LibraryLoansView extends StatelessWidget {
  const LibraryLoansView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis prestamos'),
      ),
      body: BlocBuilder<LoanListBloc, LoanListState>(
        builder: (context, state) {
          if (state.status == LoanListRequestStatus.failure) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          if (state.status == LoanListRequestStatus.success) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              itemCount: state.loans.length,
              itemBuilder: (_, index) => LoanItem(state.loans[index]),
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
