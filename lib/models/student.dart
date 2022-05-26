import 'package:equatable/equatable.dart';

class Student extends Equatable {
  const Student({
    this.fullName = '',
    this.career = '',
    this.representative = '',
    this.country = '',
    this.mail = '',
    this.sex = '',
    this.imageUrl = '',
  });

  factory Student.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return Student(
      fullName: parsedJson['fullname'] as String,
      career: parsedJson['career'] as String,
      representative: parsedJson['representative'] as String,
      country: parsedJson['country'] as String,
      mail: parsedJson['mail'] as String,
      sex: parsedJson['sex'] as String,
      imageUrl: parsedJson['imageUrl'] as String,
    );
  }

  final String fullName;
  final String career;
  final String representative;
  final String country;
  final String mail;
  final String sex;
  final String imageUrl;

  Student copyWith({
    String? fullName,
    String? career,
    String? representative,
    String? country,
    String? mail,
    String? sex,
    String? imageUrl,
  }) {
    return Student(
      fullName: fullName ?? this.fullName,
      career: career ?? this.career,
      representative: representative ?? this.representative,
      country: country ?? this.country,
      mail: mail ?? this.mail,
      sex: sex ?? this.sex,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props =>
      [fullName, career, representative, country, mail, sex, imageUrl];
}
