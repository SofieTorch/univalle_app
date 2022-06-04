import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/app/view/app.dart';
import 'package:univalle_app/data/providers/providers.dart';
import 'package:univalle_app/data/repositories/library_repository.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/library/library.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LibrarySearchBloc>(
      create: (context) => LibrarySearchBloc(
        libraryRepository: LibraryRepository(
          libraryProvider: LibraryProvider(
            storageProvider: context.read<StorageProvider>(),
          ),
        ),
      ),
      child: const LibraryView(),
    );
  }
}

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<LibrarySearchBloc, LibrarySearchState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionInProgress &&
            ModalRoute.of(context)!.isCurrent) {
          Navigator.pushNamed(
            context,
            AppRouter.libraryResults,
            arguments: context.read<LibrarySearchBloc>(),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.libraryPageAppBarTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Busca en biblioteca',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const SizedBox(height: 4),
                const SearchTextField(),
                const SizedBox(height: 36),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.libraryLoans);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l10n.libraryPageLoansButtonText),
                      const Icon(MdiIcons.arrowRight),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
