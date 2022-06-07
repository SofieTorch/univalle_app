import 'package:equatable/equatable.dart';

class Campus extends Equatable {
  const Campus({
    required this.id,
    required this.address,
    required this.name,
  });

  factory Campus.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return Campus(
      id: parsedJson['id'] as int,
      address: parsedJson['address'] as String,
      name: parsedJson['name'] as String,
    );
  }

  static const empty = Campus(address: '', name: '', id: 0);

  final int id;
  final String address;
  final String name;

  @override
  List<Object?> get props => [id, address, name];
}
