part of 'discount_list_bloc.dart';

abstract class DiscountListEvent extends Equatable {
  const DiscountListEvent();
}

class DiscountListRequested extends DiscountListEvent {
  const DiscountListRequested();

  @override
  List<Object> get props => [];
}
