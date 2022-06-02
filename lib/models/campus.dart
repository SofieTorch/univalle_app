import 'package:equatable/equatable.dart';

class Campus extends Equatable {
  const Campus({
    required this.id,
    required this.address,
    required this.name,
  });

  static const empty = Campus(address: '', name: '', id: 0);

  final int id;
  final String address;
  final String name;

  @override
  List<Object?> get props => [id, address, name];
}
