import 'package:equatable/equatable.dart';

class Procedure extends Equatable {
  Procedure({
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
      price: parsedJson['price'] as double,
      requiresInvoice: parsedJson['needsInvoice'] as bool,
      requirements: parsedJson['requirements'] as List<String>,
    );
  }

  String name;
  int estimatedDays;
  double price;
  bool requiresInvoice;
  List<String> requirements;


  @override
  List<Object?> get props => [name, estimatedDays, price, requiresInvoice, requirements];
}
