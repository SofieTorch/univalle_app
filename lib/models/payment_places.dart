import 'package:equatable/equatable.dart';
import 'package:univalle_app/environment.dart';

// ignore: camel_case_types
class Payments_Places extends Equatable {
  const Payments_Places({
    required this.category,
    required this.name,
    required this.type,
    required this.logoImageUrl,
  });

  factory Payments_Places.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;

    return Payments_Places(
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
