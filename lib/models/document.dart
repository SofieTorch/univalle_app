import 'package:equatable/equatable.dart';

class Document extends Equatable {
  const Document({
    required this.deliveryDate,
    required this.expirationDate,
    required this.quantity,
    required this.required,
    required this.name,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      deliveryDate: _dateTimeFromString(json['deliveryDate'] as String),
      expirationDate: _dateTimeFromString(json['expirationDate'] as String),
      quantity: json['quantity'] as int,
      required: json['required'] as bool,
      name: json['type'] as String,
    );
  }

  final DateTime deliveryDate;
  final DateTime expirationDate;
  final int quantity;
  final bool required;
  final String name;

  static DateTime _dateTimeFromString(String date) {
    final arr = date.split('/');
    return arr[0].isEmpty
        ? DateTime(0)
        : DateTime(int.parse(arr[2]), int.parse(arr[1]), int.parse(arr[0]));
  }

  @override
  List<Object?> get props =>
      [deliveryDate, expirationDate, quantity, required, name];
}
