import 'package:equatable/equatable.dart';

class Student extends Equatable {

  final String fullName;
  @override
  List<Object?> get props => [fullName];

  
  
}