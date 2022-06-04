import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:univalle_app/library/library.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({this.initialValue, Key? key}) : super(key: key);
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibrarySearchBloc, LibrarySearchState>(
      buildWhen: (prev, curr) => prev.searchText != curr.searchText,
      builder: (context, state) {
        return TextFormField(
          initialValue: initialValue,
          onChanged: (searchText) => context
              .read<LibrarySearchBloc>()
              .add(SearchTextChanged(searchText)),
          decoration: InputDecoration(
            errorText: state.searchText.invalid
                ? 'La busqueda no puede estar vacia'
                : null,
            suffixIcon: const Icon(MdiIcons.magnify),
            hintText: 'Titulo, autor, contenido...',
          ),
          onFieldSubmitted: (searchText) {
            context.read<LibrarySearchBloc>().add(const SearchSubmitted());
          },
        );
      },
    );
  }
}
