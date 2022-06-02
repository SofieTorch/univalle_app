import 'package:univalle_app/data/providers/providers.dart';

class LibraryRepository {
  const LibraryRepository({
    required LibraryProvider libraryProvider,
  }) : _provider = libraryProvider;

  final LibraryProvider _provider;
}
