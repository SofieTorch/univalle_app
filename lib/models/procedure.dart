
import 'package:equatable/equatable.dart';

class Procedure extends Equatable{
  String name;
  int estimatedDays;
  double price;
  bool requiresInvoice;
  List<String> requirements;
  
  Procedure({
    this.name = '',
    this.estimatedDays = 1,
    this.price = 0,
    this.requiresInvoice = true,
    this.requirements = const <String>[],
  });

  Procedure.fromJson(Map<String, dynamic> json) :
      name = json['name'] as String,
      estimatedDays = json['estimatedDays'] as int,
      price = json['price'] as double,
      requiresInvoice = json['requiresInvoice'] as bool,
      requirements = json['requirements'] as List<String>;
  

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  
}
