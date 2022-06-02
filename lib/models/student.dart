import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Student extends Equatable {
  Student({
    this.fullName = '',
    this.career = '',
    this.representative = '',
    this.country = '',
    this.mail = '',
    this.sex = '',
    this.imageUrl = '',
    this.birthDate = '',
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
      birthDate: _getDateFromString(parsedJson['birthDate'] as String),
    );
  }

  static String _getDateFromString(String date) {
    final dateArr = date.split('/').map(int.parse).toList();
    String format = ('${dateArr[0]}/${dateArr[1]}/${dateArr[2]}').toString();
    return format;
  }

  final String fullName;
  final String career;
  final String representative;
  final String country;
  final String mail;
  final String sex;
  final String imageUrl;
  final String birthDate;

  Student copyWith({
    String? fullName,
    String? career,
    String? representative,
    String? country,
    String? mail,
    String? sex,
    String? imageUrl,
    String? birthDate,
  }) {
    return Student(
      fullName: fullName ?? this.fullName,
      career: career ?? this.career,
      representative: representative ?? this.representative,
      country: country ?? this.country,
      mail: mail ?? this.mail,
      sex: sex ?? this.sex,
      imageUrl: imageUrl ?? this.imageUrl,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        career,
        birthDate,
        representative,
        country,
        mail,
        sex,
        imageUrl
      ];
}
