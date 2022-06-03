import 'package:equatable/equatable.dart';
import 'package:univalle_app/models/book.dart';

class Loan extends Equatable {
  const Loan({
    required this.book,
    required this.loanDate,
    required this.returnDate,
  });

  factory Loan.fromJson(dynamic json, [Book? book]) {
    final parsedJson = json as Map<String, dynamic>;
    return Loan(
      loanDate: _dateTimeFromString(parsedJson['loanDate'] as String),
      returnDate: _dateTimeFromString(parsedJson['returnDate'] as String),
      book: book ?? const Book(),
    );
  }

  static DateTime _dateTimeFromString(String date) {
    final arr = date.split('/');
    return arr.isEmpty
        ? DateTime(0)
        : DateTime(int.parse(arr[2]), int.parse(arr[1]), int.parse(arr[0]));
  }

  final Book book;
  final DateTime loanDate;
  final DateTime returnDate;

  @override
  List<Object?> get props => [book, loanDate, returnDate];
}
