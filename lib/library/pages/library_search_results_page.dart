import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/library/library.dart';

class LibrarySearchResultsPage extends StatelessWidget {
  const LibrarySearchResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.librarySearchResultsPageAppBar)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchTextField(
              initialValue: context.select<LibrarySearchBloc, String>(
                (value) => value.state.searchText.value,
              ),
            ),
          ),
          BlocBuilder<LibrarySearchBloc, LibrarySearchState>(
            builder: (context, state) {
              if (state.status == FormzStatus.submissionFailure) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }

              if (state.status == FormzStatus.submissionInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.searchResults.isEmpty) {
                return const Expanded(
                  child: WithoutResultsMessage(),
                );
              }

              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.searchResults.length,
                  itemBuilder: (_, index) =>
                      BookListItem(state.searchResults[index]),
                  separatorBuilder: (_, index) => const SizedBox(height: 24),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
