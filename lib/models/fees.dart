import 'package:equatable/equatable.dart';

class Fees extends Equatable {
  const Fees({
    required this.price,
    required this.paidStatus,
    required this.expirationDate,
  });

  factory Fees.fromJson(dynamic json) {
    final parsedJson = json as Map<String, dynamic>;
    return Fees(
      expirationDate: parsedJson['expirationDate'] as String,
      paidStatus: parsedJson['paidStatus'] as bool,
      price: parsedJson['price'] as int,
    );
  }

  static String _getDateFromString(String date) {
    final dateArr = date.split('/').map(int.parse).toList();
    final format = '${dateArr[0]}/${dateArr[1]}/${dateArr[2]}';
    return format;
  }

  final int price;
  final bool paidStatus;
  final String expirationDate;

  @override
  List<Object?> get props => [price, paidStatus, expirationDate];
}
