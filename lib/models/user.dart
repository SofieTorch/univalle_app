import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.code,
  });

  final String? code;

  @override
  List<Object?> get props => [code];

  /// Empty user which represents an unauthenticated user.
  static const empty = User(code: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;
}
