import 'package:equatable/equatable.dart';
import 'package:univalle_app/environment.dart';
import 'package:univalle_app/models/campus.dart';

class Place extends Equatable {
  const Place({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.campus,
  });

  factory Place.fromJson(Map<String, dynamic> json, [Campus? campus]) {
    return Place(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: 'https://${Environment.host}${json['imageUrl'] as String}',
      campus: campus ?? Campus.empty,
    );
  }

  final int id;
  final String name;
  final String imageUrl;
  final Campus campus;

  @override
  List<Object?> get props => [id, name, imageUrl, campus];
}
