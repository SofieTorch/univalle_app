import 'package:equatable/equatable.dart';

class Procedure extends Equatable {
  const Procedure({
    this.name = '',
    this.estimatedDays = 1,
    this.price = 0,
    this.requiresInvoice = true,
    this.requirements = const <String>[],
  });

  factory Procedure.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return Procedure(
      name: parsedJson['name'] as String,
      estimatedDays: parsedJson['estimatedDays'] as int,
      price: (parsedJson['price'] as int).toDouble(),
      requiresInvoice: parsedJson['needsInvoice'] as bool,
      requirements: (parsedJson['requirements'] as List<dynamic>)
          .map((dynamic e) => e.toString())
          .toList(),
    );
  }

  final String name;
  final int estimatedDays;
  final double price;
  final bool requiresInvoice;
  final List<String> requirements;

  @override
  List<Object?> get props => [
        name,
        estimatedDays,
        price,
        requiresInvoice,
        requirements,
      ];
}
