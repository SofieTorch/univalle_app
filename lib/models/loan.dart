import 'package:equatable/equatable.dart';
import 'package:univalle_app/models/book.dart';

class Loan extends Equatable {
  const Loan({
    required this.book,
    required this.loanDate,
    required this.returnDate,
  });

  final Book book;
  final DateTime loanDate;
  final DateTime returnDate;

  @override
  List<Object?> get props => [book, loanDate, returnDate];
}
