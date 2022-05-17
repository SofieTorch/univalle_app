/// Thrown when a value from shared preferences
/// fails to be saved.
class StorageSaveFailure implements Exception {
  const StorageSaveFailure([
    this.message = 'The value could not be saved.',
  ]);

  /// The associated error message.
  final String message;
}

/// Thrown when a value from shared preferences
/// fails to be deleted.
class StorageRemoveFailure implements Exception {
  const StorageRemoveFailure([
    this.message = 'The value could not be removed.',
  ]);

  /// The associated error message.
  final String message;
}
