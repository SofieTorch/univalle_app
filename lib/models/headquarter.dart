import 'package:equatable/equatable.dart';

class Headquarter extends Equatable {
  const Headquarter({
    required this.id,
    required this.department,
  });

  factory Headquarter.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return Headquarter(
      id: parsedJson['id'] as int,
      department: parsedJson['department'] as String,
    );
  }

  static const empty = Headquarter(id: 0, department: '');

  final int id;
  final String department;

  @override
  List<Object?> get props => [id, department];
}
