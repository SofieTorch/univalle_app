import 'package:equatable/equatable.dart';
import 'package:univalle_app/environment.dart';

class PaymentsPlaces extends Equatable {
  const PaymentsPlaces({
    required this.category,
    required this.name,
    required this.type,
    required this.logoImageUrl,
  });

  factory PaymentsPlaces.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return PaymentsPlaces(
      category: parsedJson['category'] as String,
      name: parsedJson['name'] as String,
      type: (parsedJson['type'] as List<dynamic>)
          .map((dynamic e) => e.toString())
          .toList(),
      logoImageUrl:
          'https://${Environment.host}${parsedJson['logoUrl'] as String}',
    );
  }

  final String category;
  final String name;
  final List<String> type;
  final String logoImageUrl;

  @override
  List<Object?> get props => [
        category,
        name,
        type,
        logoImageUrl,
      ];
}
