import 'package:equatable/equatable.dart';
import 'package:univalle_app/environment.dart';

class Discount extends Equatable {
  const Discount({
    required this.id,
    required this.establishmentName,
    required this.establishmentImageUrl,
  });

  factory Discount.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;

    return Discount(
      id: parsedJson['id'] as int,
      establishmentName: parsedJson['bussinessName'] as String,
      establishmentImageUrl:
          'https://${Environment.host}${parsedJson['logoUrl'] as String}',
    );
  }

  final int id;
  final String establishmentName;
  final String establishmentImageUrl;

  @override
  List<Object?> get props => [id, establishmentName, establishmentImageUrl];
}
